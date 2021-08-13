Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#index'
  resources :books, only: [:index, :create, :show]
  resources :users, only: [:index, :create, :show, :edit]
end
