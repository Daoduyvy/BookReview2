Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  resources :categories
  resources :users do
    member do
      get :following , :followers
    end
  end
  resources :books do
	  resources :reviews
  end
  resources :relationships,only: [:create, :destroy]
  root 'books#index'
end
