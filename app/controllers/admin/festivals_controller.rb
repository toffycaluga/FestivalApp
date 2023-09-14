class Admin::FestivalsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_festival, only: [:show, :edit, :update, :destroy,:process_assign_organizers]
    layout "admin_layout"
    def close_applications
        @festival = Festival.find(params[:festival_id])
        @festival.update(application_state: false)
        redirect_to admin_festival_path(@festival), notice: "Postulaciones cerradas"
    end

    def close_festival
        @festival = Festival.find(params[:festival_id])
        if @festival.update(state: false)
          # Cambiar el rol de los organizadores a "Usuario"
          @festival.admin_festival_organizers.each do |organizer|
            organizer.user.update(role: "Usuario")
          end
      
          redirect_to admin_festival_path(@festival), notice: "Festival cerrado y roles de organizadores cambiados a usuarios."
        else
          redirect_to admin_festival_path(@festival), alert: "Error al cerrar el festival."
        end
    end
    
    def assign_organizers
        @festivals = current_user.festivals.where(state: true)
    end
    def show
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
    def editar_estado_postulacion
      @festival = Festival.find(params[:id])
   @applies = @festival.applies.where(terms_and_conditions_accepted: true)
    @postulantes = User.all.pluck(:name)
      
    end
    
    def actualizar_estado_postulacion
      @festival = Festival.find(params[:id])
      @apply = Apply.find(params[:apply_id])
    
      if @apply.update(quedo_en_festival: true)
        redirect_to admin_festival_path(@festival), notice: 'Estado de postulación actualizado correctamente.'
      else
        Rails.logger.error(@apply.errors.inspect) # Esto registrará los errores en el registro de Rails.
   
        redirect_to admin_festival_path(@festival), alert: 'Estado de postulación no se actualizado correctamente.'
      end
    end
    
    
    def seleccionar_festival
      @festivales_activos = Festival.where(state: true)
    end

    def personas_que_quedaron
      @festival = Festival.find_by(state: true) # Obtener el festival activo basado en el atributo `state`
      if @festival
        @personas_que_quedaron = @festival.applies.includes(:user).where(quedo_en_festival: true).map(&:user)

      else
        @personas_que_quedaron = [] # Si no hay festival activo, establecer la lista como vacía o manejar de acuerdo a tu lógica
      end
    end   
    
      private
    
      def set_festival
        @festival = Festival.find(params[:id])
      end
      def apply_params
        params.require(:apply).permit(:quedo_en_festival,:festival_id,:apply_id)
      end
     
end
