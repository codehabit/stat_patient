Rails.application.routes.draw do
  devise_for :users
  resources :patients
  resources :practitioners
  resources :messages
  resources :images
  root to: "home#index"
end

