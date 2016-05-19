Rails.application.routes.draw do
  scope 'templates', controller: 'templates' do
    post '/html-to-slim', to: 'templates#html_to_slim'
    root action: :index, as: :templates
  end

  get '/payment/execute', to: 'wizard#execute_payment', as: :execute_payment
  get '/subscribe/callback', to: 'user_pages#subscribe_callback'
  post '/subscribe/callback', to: 'user_pages#subscribe_callback'
  get 'robots.txt', to: 'pages#robots_txt'
  get 'w', to: 'wizard#new_and_allow'
  get 'user_logged', to: 'user_pages#user_logged', as: :user_logged

  scope 'emails', controller: 'emails' do
    root action: :index, as: :emails
    get 'confirmation_instructions', as: :confirmation_instructions_email
    get 'reset_password_instructions', as: :reset_password_instructions_email
    get 'unlock_instructions', as: :unlock_instructions_email
  end

  wizard_path = '/ordering-crowdsourced-testing'

  scope 'wizard' do
    root to: 'wizard#short_wizard', as: :short_wizard
  end

  scope wizard_path do
    root to: 'wizard#new', as: :wizard
    post ':id/promo_code', to: 'wizard#promo_code'
    delete ':id/promo_code', to: 'wizard#cancel_promo_code',
                             as: :cancel_promo_code
    post ':id/payment', to: 'wizard#payment', as: :test_payment
    post ':id/pay-later', to: 'wizard#pay_later', as: :pay_later
    delete '/:id/:asset_field_name/:asset_id', to: 'wizard#delete_files'
    post ':id/:asset_field_name', to: 'wizard#upload_files'
    delete '/:id', to: 'wizard#destroy'
    get '/:id', to: 'wizard#edit_or_show', as: :test
    put '/:id', to: 'wizard#update'
    post '', to: 'wizard#create' # , as: 'wizard'
  end

  get '/crowdsourced-testing-cost', to: 'pages#pricing'
  get '/crowdsourced-company-about', to: 'pages#about'
  get 'sitemap', format: :xml, to: 'sitemap#index', as: :sitemap
  get 'mail', to: 'yandex#mail_form'
  post 'schedule-call', to: 'contact#schedule_call', as: :schedule_call

  post '/subscribe', to: 'user_pages#subscribe'
  post 'update_subscription', to: 'user_pages#update_subscription'
  match '/profile', to: 'user_pages#profile', via: [:get, :post]
  post 'sign-up', to: 'user_pages#registrations__create'
  get '/sign-up/(:provider)', to: 'user_pages#registrations__new'
  get '/crowdsourced-testing-faq', to: 'faq_articles#index', as: :faq
  get '/crowdsourced-testing-faq/:id', to: 'faq_articles#show', as: :faq_article

  scope "dashboard", controller: "dashboard" do
    root action: 'index', as: :dashboard
    scope 'project/:project_id' do
      root action: 'project', as: :dashboard_project
      scope "bug-list" do
        root action: "project_bug_list", as: :dashboard_project_bug_list
        get ":bug_id", action: "project_bug", as: :dashboard_project_bug
      end

    end
  end


  DynamicRouter.load unless ARGV.grep(/(assets:(precompile|clean))|(db:migrate)/).any?

  resources :attachments, controller: :assets
  get 'geo', to: 'application#geo'

  devise_for :users, controllers: { confirmations: 'users/confirmations',
                                    sessions: 'users/sessions',
                                    passwords: 'users/passwords',
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'sign-in/:provider', to: 'users/sessions#create'
  end

  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: :rails_admin
  post 'contact_feedback', to: 'contact#contact_feedback'
  post 'faq-request', to: 'faq_articles#request_question'
  get 'faq_articles', to: 'faq_articles#articles', as: :faq_index

  post '/delete_dashboard_project', to: 'wizard#delete_dashboard_project'
  get '/dashboard_projects', to: 'wizard#dashboard_projects'
  get 'wizard/new_test_available_steps'
  get 'wizard/available_platforms_by_product_type/:product_type',
      to: 'wizard#available_platforms_by_product_type'

  get '/svg_images', to: 'home#svg_images'

  post '/save_project', to: 'wizard#save_project'

  match '*not_found_url', to: 'errors#not_found',
        via: [:get, :post, :put, :patch, :update, :delete, :create]

  root to: 'pages#home'
end
