Rails.application.routes.draw do
  devise_for :users
  resources :patients
  resources :specialists
  root to: "home#index"
end

