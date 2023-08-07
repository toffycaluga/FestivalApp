class Usuario::DashboardController < ApplicationController
    layout 'user_layout' 
    def applies
        @applies = current_user.applies
    end
    def index

    end
end
