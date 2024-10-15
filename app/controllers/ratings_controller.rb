class RatingsController < ApplicationController
  before_action :set_movie

  # GET /ratings or /ratings.json
  def index
    @ratings = @movie.ratings.included_resources.order_desc
  end

  # GET /ratings/new
  def new
    @rating = @movie.ratings.new

    Category.all.each { |c| @rating.category_ratings.build(category: c) }
  end

  # POST /ratings or /ratings.json
  def create
    @rating = @movie.ratings.new(rating_params)

    respond_to do |format|
      if @rating.save
        format.html { redirect_to movie_url(@movie), notice: "Rating was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating ||= Rating.find(params[:id])
    end

    def set_movie
      @movie ||= Movie.find(params[:movie_id])
    end

    # Only allow a list of trusted parameters through.
    def rating_params
      params.require(:rating).permit(
        category_ratings_attributes: %i[id score category_id]
      )
    end
end
