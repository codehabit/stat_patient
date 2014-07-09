Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  resources :patients
  resources :practitioners
  resources :cases
  resources :images
  root to: "home#index"
end

