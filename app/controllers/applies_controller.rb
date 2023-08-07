class AppliesController < ApplicationController
  layout :set_layout
  before_action :set_apply, only: %i[ show edit update destroy ]

  # GET /applies or /applies.json
  def index
    if current_user.role == "Usuario"
      @user_applies = current_user.applies
    elsif current_user.role == "Admin" || current_user.role == "Organizor"
    @applies = Apply.all
    end
  end

  # GET /applies/1 or /applies/1.json
  def show
    @apply.category=Category.find(@apply.category_id)
  end

  # GET /applies/new
  def new
    @festival = Festival.find(params[:festival_id])
    @apply = @festival.applies.build
  end
  

  # GET /applies/1/edit
  def edit
  end

  # POST /applies or /applies.json
  def create
    @festival = Festival.find(params[:festival_id])
    @apply = @festival.applies.build(apply_params)
    @apply.user = current_user
    respond_to do |format|
      if @apply.save
        redirect_to request.fullpath, notice: 'Comentario creado correctamente.'
        format.json { render :show, status: :created, location: @apply }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @apply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applies/1 or /applies/1.json
  def update
    respond_to do |format|
      if @apply.update(apply_params)
        format.html { redirect_to festival_apply_path(@apply), notice: "Apply was successfully updated." }
        format.json { render :show, status: :ok, location: @apply }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @apply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applies/1 or /applies/1.json
  def destroy
    @apply.destroy

    respond_to do |format|
      format.html { redirect_to festival_applies_path, notice: "Apply was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apply
      @apply = Apply.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def apply_params
      params.require(:apply).permit(:name, :act, :description, :video_url, :festival_id, :user_id, :category_id)
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
