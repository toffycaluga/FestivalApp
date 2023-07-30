Rails.application.routes.draw do
  get 'home/index'
  devise_for :users

  # Rutas para los dashboards de cada rol
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end

  namespace :jurado do
    get 'dashboard', to: 'dashboard#index'
  end

  namespace :usuario do
    get 'dashboard', to: 'dashboard#index'
  end

  namespace :organizador do
    get 'dashboard', to: 'dashboard#index'
  end
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
