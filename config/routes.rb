Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about'
  get 'users/:id/follow' => 'users#follow',as:'users_follow'
  get 'users/:id/follower' => 'users#follower',as:'users_follower'
  resources :users,only: [:show,:index,:edit,:update]
  resources :relationships, only: [:create, :destroy]
  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy]
  end
end