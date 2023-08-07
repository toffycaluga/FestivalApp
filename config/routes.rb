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
  
  end

  namespace :organizador do
    get 'dashboard', to: 'dashboard#index'
  end
  # Definir la ruta root según el rol del usuario
  root 'home#dashboard_redirect'

end
