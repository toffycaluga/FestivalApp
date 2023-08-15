class HomeController < ApplicationController
  def index
  end
  def dashboard_redirect
      if user_signed_in?
        case current_user.role
        when 'Admin'
          redirect_to admin_dashboard_path
        when 'Jurado'
          redirect_to jurado_dashboard_path
        when 'Usuario'
          redirect_to usuario_dashboard_path
        when 'Organizador'
          redirect_to organizador_dashboard_path
        end
    else
      # Si el usuario no ha iniciado sesión, redirigirlo a la página de inicio de sesión.
      redirect_to new_user_session_path
    end
  end
end
