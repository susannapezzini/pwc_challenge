Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users
  root to: 'pages#home'

  get 'dashboard', to: 'pages#dashboard'
  get 'overview', to: 'pages#overview'
  #get 'settings', to: 'pages#settings'

  resources :banks do

  end

  resources :products do
    resources :pricings, only: [:edit, :update]
  end

end
