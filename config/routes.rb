Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  get 'smoothies', to: 'pages#smoothies'
  get 'smoothie', to: 'pages#smoothie'

  resources :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
