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
  configure_codemirror_html_field(:content)
  field :banner
  field :content if !hide_content
  html_block_fields
  field :url
  field :seo_tags
  field :sitemap_record
end

def configure_codemirror_html_field(name)
  configure name, :code_mirror do
    theme = "monokai" # night

    assets do
      {
          mode: '/assets/codemirror/modes/xml.js',
          theme: "/assets/codemirror/themes/#{theme}.css",
      }
    end

    config do
      {
          mode: 'xml',
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
      field name.to_sym
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

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show

    nestable
  end

  config.included_models = [Wizard::ProjectLanguage, Wizard::ReportLanguage, Wizard::ProductType, Wizard::TestType, Wizard::TestPlatform, Wizard::Test, Wizard::Platform, Wizard::Device, Wizard::Manufacturer, User, FaqArticle, ScheduleCallRequest, FormConfig, FormConfigs::FaqRequest, FormConfigs::ContactFeedback, FormConfigs::ScheduleCall, FaqRequest, ContactFeedback]


  include_pages_models(config)
  include_models(config, MetaData, Page, SitemapElement, Banner, HtmlBlock, KeyedHtmlBlock)


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


  %w(FaqRequest ContactFeedback ScheduleCall).each do |name|
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

  config.model FormConfig do
    visible false
  end



  config.model KeyedHtmlBlock do
    configure_codemirror_html_field :content
    pages_navigation_label
    weight 50

    list do
      field :key
    end

    edit do
      field :key
      field :content
    end
  end

  config.model HtmlBlock do
    visible false
    configure_codemirror_html_field(:content)

    edit do
      field :key
      field :content
    end

    nested do
      field :key do
        hide
      end

      field :content
    end
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

  config.model MetaData do
    visible false

    nested do
      field :head_title
      field :keywords
      field :description
    end
  end

  config.model Page do
    visible false

    edit do
      page_fields
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



  config.model SitemapElement do
    visible false

    field :display_on_sitemap
    field :changefreq
    field :priority
  end
end
