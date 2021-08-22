Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#index'
  resources :users
  resources :books do
    resource :favorites, only: [:create, :destroy]
  end
end
