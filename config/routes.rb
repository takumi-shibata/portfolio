Rails.application.routes.draw do

  root 'homes#top'
  get 'homes/about'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show, :edit, :update]
  resources :posts do
  	 resources :post_comments, only: [:create, :destroy]
  	 resource :favorites, only: [:create, :destroy]
  	 resources :maps, only: [:show]
  end
end
