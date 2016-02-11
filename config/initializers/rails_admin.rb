require_relative "require_libs"

def pages_models
  Dir[Rails.root.join("app/models/pages/*")].map{|p| filename = File.basename(p, ".rb"); "Pages::" + filename.camelize }
end

def include_pages_models(config)
  include_models(config, *pages_models)
end

def include_models(config, *models)
  models.each do |model|
    config.included_models += [model]

    if !model.instance_of?(Class)
      Dir[Rails.root.join("app/models/#{model.underscore}")].each do |file_name|
        require file_name
      end

      model = model.constantize rescue nil
    end

    if model.respond_to?(:translates?) && model.translates?
      config.included_models += [model.translation_class]
    end
  end
end

def content_field(name = :content)
  field name, :text do
    html_attributes do
      {
          class: "my-codemirror",
          mode: "slim"
      }
    end

    def value
      bindings[:object].send(name)
    end
  end
end

def pages_navigation_label
  navigation_label do
    I18n.t("admin.navigation_labels.pages")
  end
end

def settings_navigation_label
  navigation_label do
    "Settings"
  end
end

def forms_navigation_label
  navigation_label do
    "Forms"
  end
end

def page_fields(hide_content = false)
  #configure_codemirror_html_field(:content)
  field :banner
  content_field  if !hide_content


  html_block_fields
  field :url
  field :seo_tags
  field :sitemap_record
end

def configure_codemirror_html_field(name)
  configure name, :code_mirror do
    theme = "night" # night
    mode = 'css'

    assets do
      {
          mode: "/assets/codemirror/modes/#{mode}.js",
          theme: "/assets/codemirror/themes/#{theme}.css",
      }
    end

    config do
      {
          mode: mode,
          theme: theme,
      }
    end
  end
end

def configure_html_blocks
  m = self.abstract_model.model
  if m.respond_to?(:html_block_field_names)

    m.html_block_field_names.each do |name|

    end
  end
end

def html_block_fields
  m = self.abstract_model.model
  if m.respond_to?(:html_block_field_names)

    m.html_block_field_names.each do |name|
      content_field name.to_sym
    end
  end
end



RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  page_model_names = %w(About Contact Dashboard Devices FaqIndex Home HowItWorks NotFound Pricing Profile RobotsTxt SignIn SignUp SitemapXml TermsOfUse TestInfo TestingServices Wizard).map{|s| "Pages::#{s}" }

  form_config_models = [FormConfigs::ContactFeedback, FormConfigs::FaqRequest, FormConfigs::PaymentRequest, FormConfigs::ScheduleCall]

  only_configurable_models = [*form_config_models, *page_model_names, WizardSettings]
  read_only_models = []

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except(only_configurable_models + read_only_models)
    end
    export
    bulk_delete
    show do
      except only_configurable_models
    end
    edit do
      except read_only_models
    end
    delete do
      except(only_configurable_models + read_only_models)
    end
    show_in_app do
      except read_only_models
    end

    ## With an audit adapter, you can add:
    # history_index
    # history_show

    nestable do
      #only [Industry, Team, Member, Benefit, UserFeedback, EmployeeFeedback, ProcessStep]
    end
  end

  config.included_models = [Wizard::ProjectLanguage, Wizard::ReportLanguage, Wizard::ProductType, Wizard::TestType, Wizard::TestPlatform, Wizard::Test, Wizard::Platform, Wizard::Device, Wizard::Manufacturer, User, FaqArticle, ScheduleCallRequest, Cms::FormConfig, FormConfigs::FaqRequest, FormConfigs::ContactFeedback, FormConfigs::ScheduleCall, FormConfigs::PaymentRequest, FaqRequest, ContactFeedback]

  include_pages_models(config)
  include_models(config, Page, Cms::MetaTags, Cms::SitemapElement, Cms::HtmlBlock, Cms::KeyedHtmlBlock, Banner)

  include_models(config, Wizard::PromoCode)

  include_models config, WizardText

  include_models config, WizardSettings

  config.model Cms::MetaTags do
    visible false

    field :title
    field :keywords
    field :description
  end

  config.model Cms::HtmlBlock do
    visible false

    field :content
  end


  config.model WizardSettings do
    settings_navigation_label

    field :hour_price
    field :enable_credit_card_payment_method
    field :enable_paypal_payment_method
  end

  config.model Wizard::TestPlatform do
    visible false
  end

  config.model Wizard::ProjectLanguage do
    list do
      field :name
    end
  end

  config.model Wizard::ReportLanguage do
    list do
      field :name
    end
  end

  config.model Wizard::Manufacturer do
    list do
      field :name
      field :devices
    end
  end

  config.model Wizard::PromoCode do
    field :password, :string
    field :percentage_discount
  end


  %w(FaqRequest ContactFeedback ScheduleCall PaymentRequest).each do |name|
    config.model "FormConfigs::#{name}" do
      settings_navigation_label
      visible true
      list do
        field :email_receivers
      end
    end
  end

  %w(FaqRequest ContactFeedback ScheduleCallRequest).each do |name|
    config.model name do
      forms_navigation_label
    end
  end





  # config.model FormConfigs::FaqRequest do
  #   settings_navigation_label
  # end

  config.model Cms::FormConfig do
    visible false
  end

  config.model Banner do
    visible false

    nested do
      field :title
      field :title_html_tag
      field :description
      field :background_image
      field :button_label
      field :button_url
    end
  end

  config.model Page do
    visible false

    edit do
      page_fields
    end
  end

  config.model Pages::RobotsTxt do
    pages_navigation_label
    edit do
      content_field
    end
  end

  config.model Pages::SitemapXml do
    pages_navigation_label
    edit do
      content_field
    end
  end

  config.model Pages::About do
    pages_navigation_label
    weight -200

    edit do
      page_fields
    end
  end

  config.model Pages::Contact do
    pages_navigation_label

    edit do
      page_fields(true)
    end
  end

  config.model Pages::Pricing do
    pages_navigation_label

    edit do
      page_fields
    end
  end

  config.model Pages::SignIn do
    pages_navigation_label

    edit do
      field :seo_tags
      field :sitemap_record
    end
  end

  config.model Pages::Profile do
    pages_navigation_label

    edit do
      field :seo_tags
      field :sitemap_record
    end
  end

  config.model Pages::SignUp do
    pages_navigation_label


    edit do
      field :seo_tags
      field :sitemap_record
    end
  end

  config.model Pages::NotFound do
    pages_navigation_label

    edit do
      field :seo_tags
      field :sitemap_record
    end
  end

  config.model Pages::TestingServices do
    pages_navigation_label

    edit do
      page_fields
    end
  end

  config.model Pages::HowItWorks do
    pages_navigation_label

    edit do
      page_fields
    end
  end

  config.model Pages::TestInfo do
    visible false
  end

  config.model Pages::Dashboard do
    pages_navigation_label

    edit do
      field :banner
      field :seo_tags
      field :sitemap_record

    end
  end


  config.model Pages::Home do
    pages_navigation_label

    edit do
      #fields :how_it_works, :what_for_you, :statistics, :plans, :devices, :feedbacks, :bottom_block
      html_block_fields


      field :seo_tags
      field :sitemap_record
    end
  end

  config.model Pages::Wizard do
    pages_navigation_label

    edit do
      field :banner
      #field :url
      field :seo_tags
      field :sitemap_record
    end
  end

  config.model Pages::Devices do
    pages_navigation_label

    edit do
      page_fields(true)
    end
  end

  config.model Pages::TermsOfUse do
    pages_navigation_label

    edit do
      page_fields

    end
  end

  config.model Pages::FaqIndex do
    pages_navigation_label

    edit do
      field :banner
      #field :url
      field :seo_tags
      field :sitemap_record
    end
  end

   config.model FaqArticle do
     pages_navigation_label
     weight 60
     edit do
       field :published
       field :name
       field :url_fragment
       field :content, :ck_editor
       field :seo_tags
       field :sitemap_record
     end
   end

  config.model Wizard::Device do
    weight -100

    object_label_method :object_label

    list do
      field :manufacturer
      field :model
      field :os
      field :screen_pixel_width
      field :screen_pixel_height
    end
  end

  config.model Wizard::ProductType do
    list do
      field :name
      field :platforms
    end
    edit do
      field :name
      field :image
      field :platforms
    end
  end

  config.model Wizard::TestType do
    list do
      field :name
    end

    edit do
      field :name
      field :image
    end
  end

  config.model Wizard::Platform do
    nestable_tree({
      position_field: :position,
      max_depth: 2
    })

    edit do
      field :name
      field :product_types
    end

    list do
      field :name
    end
  end

  config.model User do
    navigation_label "Users"
    list do
      field :username
      field :email
      field :confirmed?, :boolean

    end

    create do
      field :username
      field :role, :enum do
        enum do
          [:admin, :user]
        end
      end
      field :email
      field :password do
        required do
          true
        end
      end

    end
    edit do
      field :subscribed
      field :username
      field :role, :enum do
        enum do
          [:admin, :user]
        end
      end
      field :email
      field :password
      field :first_name
      field :last_name
      field :country
      field :city
      field :zip_code
      field :company_url
      field :image


    end
  end



  config.model Cms::SitemapElement do
    visible false

    field :display_on_sitemap
    field :changefreq
    field :priority
  end

  config.model Wizard::Test do
    edit do
      group :basic do
        field :test_type
        field :product_type
      end

      group :platforms do
        field :hours_per_tester
      end

      group :project_info do
        field :project_name
        field :project_version
        field :project_languages, :text
        field :report_languages, :text
        field :project_info_comment
      end

      group :test_plan do
        field :methodology_type
        field :exploratory_description
        field :test_case_files
        field :main_components
      end

      group :project_access do
        field :project_url
        field :test_files
        field :authentication_required
        field :auth_login
        field :auth_password
        field :contact_person_name
        field :contact_person_email
        field :contact_person_phone
        field :project_access_comment
      end

      group :other do
        field :total_price
        #field :total_price_with_discount
        field :percentage_discount do
          read_only true
        end
        field :percent_completed do
          def value
            bindings[:object].percent_completed_counter
          end
        end
        field :admin_comment, :ck_editor
      end
    end
  end

  config.model WizardText do
    edit do
      content_field :wizard_help_slim
    end
  end
end
