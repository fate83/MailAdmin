Rails.application.routes.draw do

  devise_for :admins

  resources :admins, except: [:show] do
    member do
      get 'edit_password'
      patch 'update_password'
    end
  end

  resources :domains

  get 'home/index'
  root to: "home#index"
end
