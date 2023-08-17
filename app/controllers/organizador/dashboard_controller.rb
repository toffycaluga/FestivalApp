class Organizador::DashboardController < ApplicationController
  layout "organizador_layout"  
  def index
    @user = current_user
    @festival_organizer = Admin::FestivalOrganizer.find_by(user_id: @user.id)
    
    if @festival_organizer
      @festival = @festival_organizer.festival
      @total_postulaciones = Apply.where(festival_id: @festival.id).count

      @postulaciones_por_categoria = Apply.where(festival_id: @festival.id).group(:category_id).count
    end
    
    # @user = current_user
    # @organized_festivals = @user.organized_festivals


  end
  def applies
    response.headers['X-Content-Type-Options'] = 'nosniff'
    @user = current_user
    @festival_organizer = Admin::FestivalOrganizer.find_by(user_id: @user.id)
    if @festival_organizer
      @festival = @festival_organizer.festival
       end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_festival_organizer
      @admin_festival_organizer = Admin::FestivalOrganizer.find(params[:id])
    end
end
