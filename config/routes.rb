Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  resources :patients
  resources :practitioners
  resources :visits
  resources :cases do
    put :reply
    put :add_participant
    put :star
  end
  resources :attachments do
    resources :annotations, only: [:index, :create, :update, :destroy]
  end
  resources :tooth_charts, only: [:show, :update]
  resources :prescription_orders do
    get :print, on: :member
    put :submit, on: :member
  end
  resources :organizations
  resources :laboratories
  resources :pharmacies
  resources :practices
  resources :drugs
  resources :laboratory_orders
  root to: "home#index"
  resources :decision_trees do
    get 'next_element', to: 'decision_trees#next_element', on: :collection
    get 'build_element', to: 'decision_trees#build_element', on: :collection
    get 'remove_element', to: 'decision_trees#remove_element', on: :collection
  end
  get 'coming_soon', to: 'home#coming_soon'
  post 'select_patient', to: 'home#index'
end

