Rails.application.routes.draw do
  get 'admins/index'

  get 'admins/new'

  resources :domains

  devise_for :admins

  resources :admins, except: [:show] do
    member do
      get 'edit_password'
    end
  end
  get 'home/index'

  root to: "home#index"
end
