Rails.application.routes.draw do
  resources :domains

  devise_for :admins
  get 'home/index'

  root to: "home#index"
end
