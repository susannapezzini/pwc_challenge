Rails.application.routes.draw do

  # get 'requests/update'
  get 'banks/new'
  get 'banks/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  
  devise_for :users
  root to: 'pages#home'

  get 'dashboard', to: 'pages#dashboard'
  get 'overview', to: 'pages#overview'
  get 'overview/tab=:id', to: 'pages#overview'
  #get 'settings', to: 'pages#settings'




  resources :banks do
    resources :websites, only: [:index, :create] # the 'new' form is displayed on the index page
    resources :subproducts, only: %i[index show new create edit update]
    resources :users, only: [:index, :new, :create]
  end

  resources :products do
    resources :pricings, only: [:edit, :update]
    resources :subproducts, only: [:index, :new, :create]
  end
  
  resources :users, only: [:edit, :update, :destroy]
  resources :websites, only: [:destroy]  # no edit, or update functionality in app
  
  resources :subproducts do
    resources :fees, only: [:new, :create, :edit, :update]
    resources :groups, only: %i[new create]
  end

  resources :prices
  resources :fees, only: %i[update]
  resources :requests, only: %i[update]
  resources :groups, only: %i[edit update destroy]

  post 'banks/:id/check_updates', to:  'banks#check_updates', as: :check_updates
  post 'banks/:id/merged_pdfs', to: 'banks#merged_pdfs'
  post 'banks/:id/bank_stats', to:  'banks#bank_stats'

  get 'banks/:id/parse', to:  'banks#parse'
end
