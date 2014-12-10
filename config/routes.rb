Rails.application.routes.draw do
  get 'admins/index'

  get 'admins/new'

  resources :domains

  devise_for :admins

  resources :admins, only: [:index, :new, :destroy]
  get 'home/index'

  root to: "home#index"
end
