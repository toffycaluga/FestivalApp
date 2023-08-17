require 'youtube_embed'
class AppliesController < ApplicationController
  layout :set_layout
  before_action :set_apply, only: %i[ show edit update destroy ]

  # GET /applies or /applies.json
  def index
    if current_user.role == "Usuario"
      @applies = current_user.applies
    elsif current_user.role == "Admin" || current_user.role == "Organizador"
    @applies = Apply.all
    end
  end

  # GET /applies/1 or /applies/1.json
  def show
    response.headers['X-Content-Type-Options'] = 'nosniff'
    @apply.category = Category.find(@apply.category_id)
  
    if @apply.video_url.present?
      @video_id = extract_youtube_video_id(@apply.video_url)
    end
      
  end

  # GET /applies/new
  def new
    @festival = Festival.find(params[:festival_id])
    @apply = @festival.applies.build
  end
  

  # GET /applies/1/edit
  def edit
    def edit
      @festival = Festival.find(params[:festival_id]) # Asegúrate de definir @festival
      @apply = @festival.applies.find(params[:id]) # 
    end
    
  end

  # POST /applies or /applies.json
  def create
    @festival = Festival.find(params[:festival_id])
    @apply = @festival.applies.build(apply_params)
    @apply.user = current_user
    respond_to do |format|
      if @apply.save
   
        format.html { redirect_to root_path, notice: 'Postulación creada correctamente.' }
        format.json { render :show, status: :created, location: @apply }
        #Confirmacion de postulación 
        UserMailer.confirmation_email(current_user, @festival).deliver_now
        # Envío de mensaje a los organizadores
        organizers = User.where(role: 'Organizador')
        organizers.each do |organizer|
          OrganizerMailer.new_application_notification(organizer, @apply).deliver_now
        end
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
      params.require(:apply).permit(:name,:apply_image, :act, :description, :video_url, :festival_id, :user_id, :category_id)
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
    def extract_youtube_video_id(url)
      if url.include?("youtube.com") || url.include?("youtu.be")
        uri = URI.parse(url)
        if uri.query
          query_params = URI.decode_www_form(uri.query)
          video_id_param = query_params.find { |param| param[0] == "v" }
          return video_id_param[1] if video_id_param
        else
          return uri.path.split("/").last
        end
      end
      nil
    end    
end
