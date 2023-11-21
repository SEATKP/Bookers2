Rails.application.routes.draw do

devise_for :users
root to: 'homes#top'
get 'home/about' => 'homes#about'
resources :books, only: [:create, :index, :show, :edit, :destroy, :update]
resources :users, only: [:show, :edit, :update, :index]
end
