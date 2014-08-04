Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  resources :patients
  resources :practitioners
  resources :cases
  resources :tooth_charts do
    resources :annotations, only: [:index, :create, :update, :destroy]
  end
  resources :attachments
  resources :prescription_orders do
    get :print, on: :member
    put :submit, on: :member
  end
  resources :organizations
  resources :drugs
  resources :laboratory_orders
  root to: "home#index"
  get 'coming_soon', to: 'home#coming_soon'
  post 'select_patient', to: 'home#index'
end

