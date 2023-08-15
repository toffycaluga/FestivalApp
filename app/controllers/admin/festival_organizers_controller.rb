class Admin::FestivalOrganizersController < ApplicationController
  before_action :set_admin_festival_organizer, only: %i[ show edit update destroy ]
  layout "admin_layout"
  # GET /admin/festival_organizers or /admin/festival_organizers.json
  def index
    @admin_festival_organizers = Admin::FestivalOrganizer.all
  end

  # GET /admin/festival_organizers/1 or /admin/festival_organizers/1.json
  def show
  end

  # GET /admin/festival_organizers/new
  def new
    @admin_festival_organizer = Admin::FestivalOrganizer.new
  end

  # GET /admin/festival_organizers/1/edit
  def edit
  end

  # POST /admin/festival_organizers or /admin/festival_organizers.json
  def create
    @festival = Festival.find(admin_festival_organizer_params[:festival_id])
    @admin_festival_organizer = @festival.admin_festival_organizers.build(admin_festival_organizer_params.except(:festival_id))

    respond_to do |format|
      if @admin_festival_organizer.save
        @admin_festival_organizer.user.update(role: "Organizador")
        format.html { redirect_to admin_festival_organizer_url(@admin_festival_organizer), notice: "Festival organizer was successfully created." }
        format.json { render :show, status: :created, location: @admin_festival_organizer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_festival_organizer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/festival_organizers/1 or /admin/festival_organizers/1.json
  def update
    respond_to do |format|
      if @admin_festival_organizer.update(admin_festival_organizer_params)
        format.html { redirect_to admin_festival_organizer_url(@admin_festival_organizer), notice: "Festival organizer was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_festival_organizer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_festival_organizer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/festival_organizers/1 or /admin/festival_organizers/1.json
  def destroy
    @admin_festival_organizer.destroy

    respond_to do |format|
      format.html { redirect_to admin_festival_organizers_url, notice: "Festival organizer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_festival_organizer
      @admin_festival_organizer = Admin::FestivalOrganizer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_festival_organizer_params
      params.require(:admin_festival_organizer).permit(:festival_id, :user_id)
    end
end
