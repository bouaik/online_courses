Rails.application.routes.draw do
  resources :enrollements do
    get "my_students", on: :collection
  end
  devise_for :users
  resources :courses do
    get :purchased, :pending_review, :created, :unapproved, on: :collection
    member do 
      patch :approve
      patch :unapprove
    end
    resources :lessons do 
      put :sort
    end
    resources :enrollements, only: [:new, :create]
  end
  resources :users, only: [:index, :edit, :show, :update]
  root 'home#index'
  get 'activity', to: "home#activity"
  get 'analytics', to: "home#analytics"
  # get 'charts/users_per_day', to: "charts#users_per_day"
  # get 'charts/enrollements_per_day', to: "charts#enrollements_per_day"
  # get 'charts/course_popularity', to: "charts#course_popularity"
  # get 'charts/money_makers', to: "charts#money_makers"
  namespace :charts do 
    get 'money_makers'
    get 'course_popularity'
    get 'enrollements_per_day'
    get 'users_per_day'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
