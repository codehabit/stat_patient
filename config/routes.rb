Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  resources :patients
  resources :practitioners
  resources :cases
  resources :images
  resources :prescription_orders
  root to: "home#index"
  get 'coming_soon', to: 'home#coming_soon'
  post 'select_patient', to: 'home#index'
end

