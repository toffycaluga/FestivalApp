class RatingsController < ApplicationController
  before_action :set_rating, only: %i[ show edit update destroy ]

  # GET /ratings or /ratings.json
  def index
    @ratings = Rating.all
  end

  # GET /ratings/1 or /ratings/1.json
  def show
  end

  # GET /ratings/new
  def new
    
    @apply = Apply.find(params[:apply_id])
    @rating = @apply.ratings.build
    @rating.user = curent_user
  end

  # GET /ratings/1/edit
  def edit
    # @rating = Rating.find(params[:id]) # Cargar la calificación existente
  end

  # POST /ratings or /ratings.json
  def create
   
    @apply = Apply.find(params[:apply_id])
    @rating = @apply.ratings.build(rating_params)
    @rating.user = current_user
   
    respond_to do |format|
      if @rating.save
        format.html { redirect_to festival_apply_path(@rating.apply.festival, @rating.apply), notice: "Calificación hecha con éxito"
        }
        format.json { render :show, status: :created, location: @rating }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ratings/1 or /ratings/1.json
  def update
    puts "llegue aqui"
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to festival_apply_path(@rating.apply.festival, @rating.apply), notice: "Calificación actualizada con éxito"
        }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1 or /ratings/1.json
  def destroy
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to ratings_url, notice: "Rating was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rating_params
      params.require(:rating).permit(:stars, :apply_id, :user_id)
    end
end
