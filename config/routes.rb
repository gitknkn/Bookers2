Rails.application.routes.draw do
  
  root 'home#home' 
  get '/home/about' => 'home#about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :books
  
  resources :users, only: [:index, :show, :edit, :update, :destroy]
end

