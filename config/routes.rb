Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'
  get 'smoothies', to: 'pages#smoothies'
  get 'smoothie', to: 'pages#smoothie'

  resources :customers do
    resources :baskets
    resources :addresses
    resources :orders
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
