require_relative "require_libs"

def pages_models
  Dir[Rails.root.join("app/models/pages/*")].map{|p| filename = File.basename(p, ".rb"); "Pages::" + filename.camelize }
end

def pages_navigation_label
  navigation_label do
    I18n.t("admin.navigation_labels.pages")
  end
end

def page_fields
  field :content
  field :url
  field :seo_tags
end

RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

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

  config.included_models = [Wizard::ProductType, Wizard::Platform]

  ( [MetaData, Page] + pages_models) .each do |model|
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

    edit do
      page_fields
    end
  end

  config.model Pages::Contact do
    pages_navigation_label

    edit do
      page_fields
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
    visible false
  end

  config.model Pages::Wizard do
    visible false
  end




   config.model FaqArticle do
     edit do
       field :published
       field :name
       field :content, :ck_editor
     end
   end

  config.model Wizard::ProductType do
    edit do
      field :name
      field :image
      field :platforms
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
  end
end
