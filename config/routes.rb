Rails.application.routes.draw do
  get "geo", to: "application#geo"
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
                                        registrations: "users/registrations",
                                        omniauth_callbacks: "users/omniauth_callbacks"
                                    }

  #devise_for :users, controllers: {registrations: "users/registrations"}
  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'home#index'
  get "about/leaders", to: "about#leaders"
  post "contact_request", to: "contact#contact_request"
  post "faq_request", to: "faq_articles#request_question"
  get "faq_articles", to: "faq_articles#articles"

  post "/delete_dashboard_project", to: "wizard#delete_dashboard_project"
  get "/dashboard_projects", to: "wizard#dashboard_projects"
  get "wizard/new_test_available_steps"
  get "wizard/available_platforms_by_product_type/:product_type", to: "wizard#available_platforms_by_product_type"

  scope "ng" do
    root to: "angular#index", as: :ng_root
    get 'wizard', to: "angular#wizard"
  end

  get "/svg_images", to: "home#svg_images"


  post "/save_project", to: "wizard#save_project"
  get 'wizard', to: "wizard#index"
  get "ng_wizard", to: "wizard#ng_wizard"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end


# add_column :users, :first_name, :string
# add_column :users, :last_name, :string
# add_column :users, :country, :string
# add_column :users, :company_url, :string