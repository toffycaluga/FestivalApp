require 'youtube_embed'
class AppliesController < ApplicationController
  include Pagy::Backend 
  
  before_action :authenticate_user!
  layout :set_layout
  before_action :set_apply, only: %i[ show edit update destroy ]

  # GET /applies or /applies.json
  def index
    if current_user.role == "Usuario"
      @pagy, @applies = pagy(current_user.applies, items: 10) 
    elsif current_user.role == "Admin" || current_user.role == "Organizador"
      @pagy, @applies = pagy( Apply.all, items: 10) 
   
    end
  end

  # GET /applies/1 or /applies/1.json
  def show
    response.headers['X-Content-Type-Options'] = 'nosniff'
    @apply.category = Category.find(@apply.category_id)
    @rating = Rating.find_by(user_id: current_user.id, apply_id: @apply.id)
    if @rating
      # Si se encontró la calificación, obtén la postulación asociada
      @apply = @rating.apply
    else
      # Si no se encontró la calificación, verifica si la postulación existe
      @apply = Apply.find_by(id: params[:id])
    end
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
    # @festival = Festival.find(params[:festival_id]) # Asegúrate de definir @festival
    # @apply = Apply.find(params[:id]) # 
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
    puts params[:apply][:terms_and_conditions_accepted]
    respond_to do |format|
      if @apply.update(apply_params)
        format.html { redirect_to root_path, notice: "Postulación actualizada con exito." }
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
      params.require(:apply).permit(:name,:apply_image, :act, :description, :video_url, :festival_id, :user_id, :category_id,:terms_and_conditions_accepted)
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
        cleaned_url = url.strip  # Esto eliminará cualquier espacio en blanco al principio y al final de la cadena
        uri = URI.parse(cleaned_url)
        
        if uri.host == "youtu.be"  # Si es un enlace de tipo youtu.be
          return uri.path[1..-1]   # Ignoramos el primer carácter ("/") en la ruta
        elsif uri.query            # Si es un enlace de tipo youtube.com con parámetros en la query
          query_params = URI.decode_www_form(uri.query)
          video_id_param = query_params.find { |param| param[0] == "v" }
          return video_id_param[1] if video_id_param
        end
      end
      
      nil  # Si no es un enlace de YouTube válido
    end
end
