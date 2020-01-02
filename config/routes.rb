# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
    namespace :admin do
    get '', to: 'base#index', as: '/'
    resources :users
    resources :charts, only: %i[index]
    resources :categories
    resources :books do
      resources :reviews
    end
  end

  resources :admin, only: %i[index delete]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :books do
    resources :reviews
  end
  resources :follows, only: %i[create destroy]
  resources :categories
  root 'books#index'
end
