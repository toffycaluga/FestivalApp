class Admin::FestivalsController < ApplicationController
    before_action :set_festival, only: [:show, :edit, :update, :destroy, :close_festival,:close_applications,:process_assign_organizers]
    layout "admin_layout"
    def close_applications
        @festival = Festival.find(params[:festival_id])
        @festival.update(application_state: false)
        redirect_to admin_festival_path(@festival), notice: "Postulaciones cerradas"
    end

    def close_festival
        @festival = Festival.find(params[:festival_id])
        @festival.update(state: false)
        redirect_to admin_festival_path(@festival), notice: "Festival cerrado"
    end
    
    def assign_organizers
        @festivals = current_user.festivals.where(state: true)
    end
    def show
      @festival = Festival.find(params[:festival_id])
    end
    
    def process_assign_organizers
      @festival = Festival.find(params[:festival_id])

      @user_ids = params[:user_ids]
      
      if @user_ids.present?
        @festival.organizers << User.where(id: @user_ids)
        redirect_to admin_festival_path(@festival), notice: 'Organizadores asignados exitosamente.'
      else
        redirect_to admin_festival_path(@festival), alert: 'Debes seleccionar al menos un usuario.'
      end
  
      
    end
    
      private
    
      def set_festival
        @festival = Festival.find(params[:festival_id])
      end
  
     
end
