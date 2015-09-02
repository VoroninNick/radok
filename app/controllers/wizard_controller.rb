class WizardController < ApplicationController

  before_action :authenticate, only: [:dashboard_projects, :delete_dashboard_project]

  def index
    @template = "/assets/wizard.html"

    render template: "layouts/ng", layout: false
  end

  def ng_wizard
    @platforms =  [
        {
            name: 'Browsers', image_path: "ie.svg", sub_items: [
            {name: 'Internet Explorer 9', count: 0},
            {name: 'Internet Explorer 10', count: 0},
            {name: 'Internet Explorer 11', count: 0},
            {name: 'Latest version of Firefox', count: 0},
            {name: 'Latest version of Chrome', count: 0},
            {name: 'Latest version of Safari', count: 0}
        ]
        },
        {
            name: "IOS", image_path: "apple.svg", sub_items: [
              { name: "iPhone 4", count: 0 },
              { name: "iPhone 5s", count: 0 },
              { name: "iPad 2", count: 0 },
              { name: "iPad Air", count: 0 },
              { name: "iPad mini", count: 0 },
              { name: "iPhone 6 Plus", count: 0 }
            ]
        },
        {
            name: "Android", image_path: "android.svg"
        }
    ]

    render file: Rails.root.join("app/assets/templates/wizard.html")
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