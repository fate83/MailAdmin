Rails.application.routes.draw do
  devise_for :admins
  get 'home/index'

  root to: "home#index"
end
