# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  resources :admins
  resources :categories
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :books do
    resources :reviews
  end
  resources :follows, only: %i[create destroy]
  root 'books#index'
end
