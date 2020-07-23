Rails.application.routes.draw do
  resources :enrollements
  devise_for :users
  resources :courses do
    resources :lessons
    resources :enrollements, only: [:new, :create]
  end
  resources :users, only: [:index, :edit, :show, :update]
  root 'home#index'
  get 'home/activity'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
