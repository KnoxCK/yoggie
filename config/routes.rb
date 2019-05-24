Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'pages#home'
  # get 'smoothies', to: 'pages#smoothies'
  get 'contact', to: 'pages#contact'
  get 'faqs', to: 'pages#faqs'
  get 'privacy', to: 'pages#privacy'


  resources :users do
    get :postcode_checker, on: :member
    patch :postcode_result, on: :member
  end

  resources :customers do
    resources :baskets do
      patch :cancel_subscription, on: :member
    end
    resources :addresses
    resources :payments, only: [:new, :create]
  end

  resources :smoothies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
