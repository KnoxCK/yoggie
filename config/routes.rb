Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'pages#home'
  get 'smoothies', to: 'pages#smoothies'
  get 'smoothie', to: 'pages#smoothie'

  resources :users do
    get :postcode_checker, on: :member
    patch :postcode_result, on: :member
  end

  resources :customers do
    resources :baskets
    resources :addresses
    resources :payments, only: [:new, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
