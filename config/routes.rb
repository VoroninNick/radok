Rails.application.routes.draw do

  post "update_subscription", to: "user_pages#update_subscription"
  get "/profile", to: "user_pages#profile"
  post "sign-up", to: "user_pages#registrations__create"
  get "/sign-up", to: "user_pages#registrations__new"
  get "faq", to: "faq_articles#index", as: :faq
  get "faq/:id", to: "faq_articles#show", as: "faq_article"

  get "dashboard", to: "dashboard#index"
  get "dashboard/project/:id", to: "dashboard#project", as: :dashboard_project
  get "wizard", to: "wizard#new"
  DynamicRouter.load
  resources :attachments, controller: :assets
  get "geo", to: "application#geo"
  devise_for :users, controllers: { confirmations: "users/confirmations", sessions: "users/sessions", passwords: "users/passwords" }
  #mount_devise_token_auth_for 'User', at: 'auth', controllers: {
  #                                      registrations: "users/registrations",
  #                                      omniauth_callbacks: "users/omniauth_callbacks"
  #                                  }

  #devise_for :users, controllers: {registrations: "users/registrations"}
  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #root to: 'home#index'
  get "about/leaders", to: "about#leaders"
  post "contact_feedback", to: "contact#contact_feedback"
  post "faq-request", to: "faq_articles#request_question"
  get "faq_articles", to: "faq_articles#articles", as: :faq_index

  post "/delete_dashboard_project", to: "wizard#delete_dashboard_project"
  get "/dashboard_projects", to: "wizard#dashboard_projects"
  get "wizard/new_test_available_steps"
  get "wizard/available_platforms_by_product_type/:product_type", to: "wizard#available_platforms_by_product_type"

  scope "ng" do
    root to: "angular#index", as: :ng_root
    #get 'wizard', to: "angular#wizard"
  end

  get "/svg_images", to: "home#svg_images"


  post "/save_project", to: "wizard#save_project"

  get "ng_wizard", to: "wizard#ng_wizard"

  match "*not_found_url", to: "errors#not_found", via: [:get, :post, :put, :patch, :update, :delete, :create]

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