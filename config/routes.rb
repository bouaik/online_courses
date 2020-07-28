Rails.application.routes.draw do
  resources :enrollements do
    get "my_students", on: :collection
  end
  devise_for :users
  resources :courses do
    get "purchased", "pending_review", "created", on: :collection
    resources :lessons
    resources :enrollements, only: [:new, :create]
  end
  resources :users, only: [:index, :edit, :show, :update]
  root 'home#index'
  get 'activity', to: "home#activity"
  get 'statistics', to: "home#statistics"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
