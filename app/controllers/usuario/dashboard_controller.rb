class Usuario::DashboardController < ApplicationController
    layout 'user_layout' 
    def applies
        @applies = current_user.applies.order(created_at: :desc)
    end
    def index
        @festivals = Festival.all.order(created_at: :desc)
    end
    def profile 
        @count_applies=current_user.applies.count()
    end
end
