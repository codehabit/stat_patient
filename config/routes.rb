Rails.application.routes.draw do
  devise_for :users
  resources :patients
  resources :practitioners
  resources :messages
  root to: "home#index"
end

