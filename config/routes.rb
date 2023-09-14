Rails.application.routes.draw do
  resources :applies do
    resources :ratings, only: [:new, :create, :edit, :update]
  end
  resources :ratings
  resources :festivals do
    # patch 'actualizar_estado_postulacion', on: :member
    resources :applies
    member do
      get 'terms', to: 'festivals#terms'
      get 'send_terms_notification'
      patch 'actualizar_estado_postulacion/:apply_id', to: 'festivals#actualizar_estado_postulacion', as: 'actualizar_estado_postulacion'
   
    end
  end
  get 'home/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  namespace :admin do
   
    get 'dashboard', to: 'dashboard#index'
    resources :festivals do
      get 'assign_organizers', on: :collection
      post 'assign_organizers', on: :collection, to: 'festivals#process_assign_organizers'
      
      member do
        post 'assign_organizers', to: 'festivals#assign_organizers'
        get 'editar_estado_postulacion', to: 'festivals#editar_estado_postulacion'
        patch 'actualizar_estado_postulacion', to: 'festivals#actualizar_estado_postulacion'
        get 'personas_que_quedaron', to: 'festivals#personas_que_quedaron'

      
      end
      collection do
        get 'assign_organizers' # Define la ruta para la acción assign_organizers
        get 'seleccionar_festival'
      end
      put :close_applications
      put :close_festival
    end
    resources :festival_organizers
    
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
    get 'dashboard/applies', to: 'dashboard#applies'
    get 'dashboard/ranking', to: 'dashboard#ranking'
  end
  # Definir la ruta root según el rol del usuario
  root 'home#dashboard_redirect'

end
