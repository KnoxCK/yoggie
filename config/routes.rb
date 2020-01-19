Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'pages#home'
  # get 'smoothies', to: 'pages#smoothies'
  get 'contact', to: 'pages#contact'
  get 'faqs', to: 'pages#faqs'
  get 'privacy', to: 'pages#privacy'
  get 'terms', to: 'pages#terms'
  get 'newsletter', to: 'pages#newsletter'
  get 'customer/choose_standard', to: 'customers#choose_standard', as: :choose_standard
  get 'customer/choose_custom', to: 'customers#choose_custom', as: :choose_custom
  get 'smoothies/:id', to: "smoothies#show", as: :smothie_page
  patch 'add_to_basket', to: 'baskets#add_to_basket', as: :add_to_basket
  patch 'update_newsletter', to: 'users#update_newsletter', as: :update_newsletter
  get 'my_nutrition/:basket_id', to: 'baskets#my_nutrition', as: :my_nutrition
  get 'update_subscription/:id', to: 'customers#update_subscription', as: :update_subscription
  get 'customers/:id/dashboard_edit', to: "customers#dashboard_edit", as: :dashboard_edit
  patch 'customers/:id/dashboard_update', to: "customers#dashboard_update", as: :dashboard_update
  get 'customers/:id/update_status', to: "customers#update_status", as: :update_status
  get 'blog', to: 'articles#index'
  get 'about', to: 'pages#about'
# basket - customers/:customer_id/baskets/:basket_id

  resources :articles, only: [:create, :new, :edit, :update]
  resources :users do
    get :postcode_checker, on: :member
    patch :postcode_result, on: :member
  end

  resources :customers do
    resources :baskets do
      patch :cancel_subscription, on: :member
      patch :pause_subscription, on: :member
    end
    resources :addresses
    resources :payments, only: [:new, :create]
  end

  get 'blog/:slug', to: "articles#show", as: :article_page

  resources :smoothies

  resources :newsletter_subscribers, only: [:create, :new]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development? || Rails.env.staging?
end
