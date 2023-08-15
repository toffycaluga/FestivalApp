class Usuario::DashboardController < ApplicationController
    include Devise::Controllers::Helpers
    before_action :devise_resource
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
    before_action :devise_resource

    def edit
        # ...
    end

    private

    def devise_resource
        # @resource = send("current_#{resource}")
    end
end
