Rails.application.routes.draw do
  get 'home/about'
  devise_for :users
  root 'users#top', as: 'top_user'
  get "home/about" => "home#about"
  resources :books
  resources :users, only: [:index, :show, :edit, :update, :destroy, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
