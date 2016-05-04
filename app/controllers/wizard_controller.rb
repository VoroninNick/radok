class WizardController < ApplicationController
  require 'paypal-sdk-rest'
  include PayPal::SDK::REST

  before_action :authenticate, only: [:dashboard_projects,
                                      :delete_dashboard_project]
  before_action :set_wizard_options, only: [:edit_or_show, :new, :new_and_allow]
  before_action :set_page_banner, only: [:edit_or_show, :new, :new_and_allow]

  def edit_or_show
    @project = Wizard::Test.find(params[:id])
    @created = true
    @head_title = "Wizard Test ##{@project.id}"
    @wizard_options = { step_disabled_unless_active_or_proceeded: false }
    if !@project.completed?
      set_page_metadata('wizard')
      @head_title = @project.project_name
      render 'new'
    else
      redirect_to dashboard_project_path(id: @project.id)
    end
  end

  def set_wizard_options
    @product_type_names = Wizard::ProductType.all.pluck(:name).to_json
    @test_type_names = Wizard::TestType.all.pluck(:name).to_json
    @product_types = Wizard::ProductType.all
    @test_types = Wizard::TestType.all
    @root_platforms = Wizard::Platform.roots
    @platforms_json = @root_platforms.map(&:recursive_to_hash).to_json
    @project_languages = Wizard::ProjectLanguage.all.pluck(:name)
    @report_languages = Wizard::ReportLanguage.all.pluck(:name)
    @platform_ids_by_product_type = Wizard::ProductType.platform_ids_by_product_type
  end

  def new
    @head_title = 'Wizard'
    @project = Wizard::Test.new
    # last_test = Wizard::Test.last
    # id =  last_test.id + 1
    id = rand(1000)
    @project.project_name = "Test ##{id}"
    @project.methodology_type ||= 'exploratory'
    @intro_step = true
    @all_platforms = Wizard::Platform.roots

    (@all_platforms.map(&:id) - @project.platforms.map(&:id)).each do |p_id|
      p = @all_platforms.where(id: p_id).first
      p.testers_count ||= 0
      @project.platforms << p
    end
    @wizard_options = { step_disabled_unless_active_or_proceeded: false }

    set_page_metadata('wizard')
    render 'new'
  end

  def short_wizard
    redirect_to wizard_path
  end

  def new_and_allow
    @allow = true
    new
  end

  def create
    @test = Wizard::Test.create(test_params)
    @test.user_id = current_user.try(&:id)
    if @test.save
      if current_user.nil?
        id = @test.id
        if !session[:tests]
          session[:tests] = [id]
        else
          if !session[:tests].include?(id)
            session[:tests] << id
          end
        end
      end
      render inline: @test.to_builder.target!, status: 201
    end
  end

  def update
    @test = Wizard::Test.find(params[:id])
    @test.update(test_params)
    render inline: @test.to_builder.target!, status: 200 if @test.save
  end

  def payment
    # with PayPal
    @test = Wizard::Test.find(params[:id])
    @payment = Payment.new({
      intent: 'sale',
      redirect_urls: {
        return_url: 'http://localhost:3000/payment/execute',
        cancel_url: "http://localhost:3000/dashboard"
      },
      payer: {
        payment_method: 'paypal'
      },
      transactions: [
        {
          amount: {
            total: @test.total_price,
            currency: 'USD'
          }
          # ,
          # description: 'This is the payment transaction description.'
        }
      ]})

    if @payment.create
      @redirect_url = @payment.links.find{ |v| v.method == 'REDIRECT' }.href
      @payment_request = PaymentRequest.create(
        payment_method: @payment.payer.payment_method,
        test_id: @test.id,
        payment_id: @payment.id,
        state: @payment.state,
        email: current_user.email,
        link: @redirect_url )

      @test.complete!
      WizardMailer.payment_request_admin_notification(@payment_request).deliver
      render json: { payment: @payment.id, redirect_url: @redirect_url }
    else
      render json: { error: @payment.error }, status: 500
    end
  end

  def execute_payment
    @payment = Payment.find(params[:paymentId])
    @payment_request = PaymentRequest.find_by(payment_id: params[:paymentId])
    @test = Wizard::Test.find(@payment_request.test_id)
    if @payment.execute(payer_id: params[:PayerID])
      @test.paid!
      respond_with_navigational{ redirect_to(dashboard_project_path(id: @test.id), flash: {payment_success: true}) }
    else
      respond_with_navigational{ redirect_to(dashboard_project_path(id: @test.id), flash: {payment_fail: true, errors: @payment.error}) }
    end
  end

  def pay_later
    pay_later_params = params[:pay_later]
    pay_later_params[:test_id] = params[:id]
    @payment = PaymentRequest.create(pay_later_params)
    @test = @payment.test
    if @payment.save
      @test.complete!
      WizardMailer.pay_later_request_admin_notification(@payment).deliver
      render inline: @payment.to_builder.target!, status: 201
    end
  end

  def promo_code
    test_id = params[:id]
    @test = Wizard::Test.find(test_id)
    promo_code_params = params[:promo_code]
    promo_code = Wizard::PromoCode.where(password: promo_code_params[:password]).first
    if promo_code
      @test.promo_code = promo_code

      if @test.save
        render json: promo_code, status: 200
      else
        render json: {}, status: 500
      end
    else
      render json: {}, status: 500
    end
  end

  def cancel_promo_code
    test_id = params[:id]
    @test = Wizard::Test.find(test_id)
    @test.promo_code = nil
    if @test.save
      render json: {}, status: 200
    else
      render json: {}, status: 400
    end
  end

  def destroy
    test_id = params[:id].to_i
    test = Wizard::Test.delete(test_id)
    if test.present?
      render json: test
    else
      render nothing: true, status: 500
    end
  end

  def upload_files
    f = params[:file]
    test = Wizard::Test.find(params[:id])
    asset_field_name = params[:asset_field_name]
    db_file = test.send "add_#{asset_field_name}", f
    test.save
    render status: 201, json: db_file
  end

  def delete_files
    asset_id = params[:asset_id].to_i
    Attachable::Asset.delete(asset_id)
    render json: {}, status: 200
  end

  def new_test_available_steps
    steps = Wizard::Test.available_steps
    render json: steps
  end

  def available_platforms_by_product_type
    product_type = params[:product_type]
    platforms = Wizard::Steps::Platforms.platforms_by_product_type(product_type)
    render json: platforms
  end

  def save_project
    data = params[:data]
    if data.is_a?(Hash)
      state = params[:state]
      data[:state] = state.to_json if state
    end
    result = {}
    if id = data.delete(:id)
      result[:action] = 'update'
      SimpleWizardTest.find(id).update(data)
    else
      result[:action] = 'create'
      t = SimpleWizardTest.create!(data)
      result[:id] = t.id
    end
    result[:success] = true
    render json: result
  end

  def dashboard_projects
    drafted_projects = SimpleWizardTest.all.map { |t| t.parse_state; t }
    data = { drafts: drafted_projects }
    render json: data
  end

  def delete_dashboard_project
    id = params[:id].try(&:to_i)
    result = {}
    if id && count = SimpleWizardTest.delete(id)
      result = { count: count }
    else
      if id.blank?
        result = { error: 'please provide id' }
      else
        result = { error: 'id does not exist' }
      end
    end
    render json: result
  end

  def test_params
    test = params[:test]
    test[:test_type_id] = Wizard::TestType.find_by_name(test.delete(:test_type)).try(&:id)
    test[:product_type_id] = Wizard::ProductType.find_by_name(test.delete(:product_type)).try(&:id)
    test[:project_language_ids] = Wizard::ProjectLanguage.where(name: test.delete(:project_languages)).map(&:id)
    test[:report_language_ids] = Wizard::ReportLanguage.where(name: test.delete(:report_languages)).map(&:id)
    test[:exploratory_description] = test.delete(:exploratory_instructions)
    test[:testers_by_platform] = test.delete(:test_platforms_bindings).try{|bindings| bindings.map{|k, b| b['platform_id'] = b.delete('subitem_id').try(&:to_i); b['test_id'] = test['id'].to_i; b['testers_count'] = b['testers_count'].to_i  ; b }  }
    test
  end

  def payment_params
    p = params[:payment]
    p[:test_id] = params[:id]
    p
  end

  def set_page_banner
    @banner = Banner.find(8)
    super
  end
end
