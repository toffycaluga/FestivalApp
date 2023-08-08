class Usuario::DashboardController < ApplicationController
    layout 'user_layout' 
    def applies
        @applies = current_user.applies.order(created_at: :desc)
    end
    def index

    end
end
