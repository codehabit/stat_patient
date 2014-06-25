Rails.application.routes.draw do
  resources :patients
  resources :specialists
  root to: "home#index"
end

