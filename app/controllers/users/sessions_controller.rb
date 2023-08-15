# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  protected

  # Este método determinará a dónde redirigir al usuario después de iniciar sesión.
  def after_sign_in_path_for(resource)
    case resource.role
    when 'Admin'
      admin_dashboard_path
    when 'Jurado'
      jurado_dashboard_path
    when 'Usuario'
      usuario_dashboard_path
    when 'Organizador'
      organizador_dashboard_path
    else
      # Si el usuario no tiene un rol válido, puedes redirigirlo a alguna otra página, como la página de inicio.
      root_path
    end
  end
end
