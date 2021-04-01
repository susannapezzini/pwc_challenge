Rails.application.routes.draw do

  get 'banks/new'
  get 'banks/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users
  root to: 'pages#home'

  get 'dashboard', to: 'pages#dashboard'
  get 'overview', to: 'pages#overview'
  #get 'settings', to: 'pages#settings'

  get 'banks/:id/manage', to: 'websites#manage', as: "manage_websites"

  resources :websites, only: [:delete]  

  resources :banks do
    resources :websites, only: [:create]  
    
  end

  resources :products do
    resources :pricings, only: [:edit, :update]
  end

end
