class Admin::DashboardController < ApplicationController
    before_action :authenticate_user!
    layout 'admin_layout' 

    def index
        # Lógica y datos para el dashboard del Admin (si es necesario)
    end
end
