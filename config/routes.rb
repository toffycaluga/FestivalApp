Rails.application.routes.draw do
  resources :festivals do
    resources :applies
  end
  get 'home/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'

  end

  namespace :jurado do
    get 'dashboard', to: 'dashboard#index'
  end

  namespace :usuario do
    get 'dashboard', to: 'dashboard#index'
    get 'dashboard/applies', to: 'dashboard#applies'
    get "user/profile/:name", to: 'dashboard#profile', as: :user_profile
    get 'user/edit/profile/:name', to: 'dashboard#edit', as: :user_profile_edit
  
  end

  namespace :organizador do
    get 'dashboard', to: 'dashboard#index'
  end
  # Definir la ruta root según el rol del usuario
  root 'home#dashboard_redirect'

end
