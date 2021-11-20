Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  get 'homes/about'

  resources :posts do
    resource :likes,  only: [:create,  :destroy]
  end

  resources :users, only: [:show, :edit, :update]

  resources :tags do
    get 'posts', to: 'posts#search'
  end
  # ネストすることで特定のタグに紐付けられた投稿ページへ
  # 遷移させるためのパスが使えるようになる

end
