class ApplicationController < ActionController::Base
  # before_action :configure_devise_locale
  

  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!
  
  before_action :set_locale
    
  protected

  def set_locale
    # Define el idioma que desees utilizar para Devise en tiempo de ejecución.
    # Puedes obtener el idioma del usuario desde su perfil o cualquier otra fuente.
    # En este ejemplo, asumiremos que el idioma está almacenado en la variable de instancia @user_locale.
    devise_locale = @user_locale || I18n.default_locale
    I18n.locale = devise_locale
  end
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar, :phone_number])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar, :phone_number])
    end
  end