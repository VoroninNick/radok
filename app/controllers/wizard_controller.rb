class WizardController < ApplicationController

  before_action :authenticate, only: [:dashboard_projects, :delete_dashboard_project]

  def edit_or_show
    @project = Wizard::Test.find(params[:id])
    @all_platforms = Wizard::Platform.roots
    @created = true
    @head_title = "Wizard Test ##{@project.id}"
    render "new"
  end

  def new
    @head_title = "Wizard"
    @project = Wizard::Test.new

    @all_platforms = Wizard::Platform.roots

    set_page_metadata("wizard")
  end

  def create
    test = Wizard::Test.create(params[:test])
    if test.save
      render json: test
    end
  end

  def update

    test = Wizard::Test.find(params[:id])
    test_params = params[:test]
    test_params[:testers_by_platform] = test_params.delete :platforms
    test.update(test_params)
    if test.save
      render json: test
    end
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
      if state
        data[:state] = state.to_json
      end
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
    drafted_projects = SimpleWizardTest.all.map{|t| t.parse_state; t }
    data = {
        drafts: drafted_projects
    }

    render json: data
  end

  def delete_dashboard_project
    id = params[:id].try(&:to_i)
    result = {}
    if id && count = SimpleWizardTest.delete(id)
      result = {count: count}
    else
      if id.blank?
        result = { error: "please provide id" }
      else
        result = { error: "id does not exist" }
      end
    end

    render json: result
  end
end



#
# rails g model Test platform:belongs_to test_type:belongs_to product_type:belongs_to
#