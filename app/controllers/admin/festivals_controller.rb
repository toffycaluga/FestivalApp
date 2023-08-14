class Admin::FestivalsController < ApplicationController

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
      private
      # Use callbacks to share common setup or constraints between actions.
     
  
     
end
