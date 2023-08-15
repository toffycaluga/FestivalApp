class FestivalsController < ApplicationController
  layout :set_layout
  before_action :set_festival, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  # GET /festivals or /festivals.json
  def index
    @festivals = Festival.all
  end

  # GET /festivals/1 or /festivals/1.json
  def show
    @festival=Festival.find(params[:id])
  end

  # GET /festivals/new
  def new
    @festival = current_user.festivals.build
  end

  # GET /festivals/1/edit
  def edit
  end

  # POST /festivals or /festivals.json
  def create
    @festival = current_user.festivals.build(festival_params)

    respond_to do |format|
      if @festival.save
        format.html { redirect_to festival_url(@festival), notice: "Festival was successfully created." }
        format.json { render :show, status: :created, location: @festival }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @festival.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /festivals/1 or /festivals/1.json
  def update
    respond_to do |format|
      if @festival.update(festival_params)
        format.html { redirect_to festival_url(@festival), notice: "Festival was successfully updated." }
        format.json { render :show, status: :ok, location: @festival }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @festival.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /festivals/1 or /festivals/1.json
  def destroy
    @festival.destroy

    respond_to do |format|
      format.html { redirect_to festivals_url, notice: "Festival was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def close_applications
    @festival = Festival.find(params[:id])
    @festival.update(application_state: false)
    redirect_to admin_festival_path(@festival), notice: "Postulaciones cerradas"
  end

  def close_festival
      @festival = Festival.find(params[:id])
      @festival.update(state: false)
      redirect_to admin_festival_path(@festival), notice: "Festival cerrado"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_festival
      @festival = Festival.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def festival_params
      params.require(:festival).permit(:name, :year, :state, :application_state, :user_id,:festival_logo, :description, :country)
    end
    def set_layout
      case current_user.role
      when 'Admin'
        'admin_layout'
      when 'Jurado'
        authorize! :read, Festival # Por ejemplo, el jurado solo puede leer (ver) los festivales
        'jurado_layout'
      when 'Usuario'
        authorize! :read, Festival # Por ejemplo, el usuario solo puede leer (ver) los festivales
        'user_layout'
      when 'Organizador'
        authorize! :manage, Festival # Por ejemplo, el organizador puede gestionar (crear, editar, eliminar) los festivales
        'organizador_layout'
      else
        # Si el rol del usuario no coincide con ninguno de los casos anteriores, utiliza el diseño predeterminado
        'application'
      end
    end
end
