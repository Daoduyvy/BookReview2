Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  get 'users/new'
  get 'users/create'
  devise_for :users
  resources :books do
	  resources :reviews
  end
  root 'books#index'
end
