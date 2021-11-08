Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  get 'homes/about'

  resources :posts
  resources :users, only: [:show, :edit, :update]
end
