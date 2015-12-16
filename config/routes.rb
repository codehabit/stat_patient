Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  resources :patients do
    put :ingest, on: :collection
  end

  resources :practitioners
  resources :visits
  resources :cases do
    put :reply
    put :add_participant
    put :star
    put :archive
    put :restore
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

  resources :laboratories, controller: 'organizations'
  resources :pharmacies, controller: 'organizations'
  resources :practices, controller: 'organizations'

  resources :drugs
  resources :laboratory_orders do
    get :print, on: :member
    post :submit, on: :member
    put :close, on: :member
  end
  root to: "home#index"
  get '/home/live', to: 'home#live'
  get '/home/inbox', to: 'home#inbox'
  get '/home/table_row/:id', to: 'home#table_row'
  resources :decision_trees do
    get 'next_element', to: 'decision_trees#next_element', on: :collection
    get 'build_element', to: 'decision_trees#build_element', on: :collection
    get 'remove_element', to: 'decision_trees#remove_element', on: :collection
  end
  get 'coming_soon', to: 'home#coming_soon'
  post 'select_patient', to: 'home#index'
end

