class Api::ArtistController < Api::BaseController	
	before_action :require_login!

	def index
		@artist = Artist.all

		respond_to do |format|
			format.json { render :json => @artist }
		end
	end

	# GET /artists/1
	# GET /artists/1.json
	def show
		@artist = Artist.find(params[:id])

		respond_to do |format|
			format.json { render :json => @artist }
		end
	end

	# GET /artists/new
	def new
		@artist = Artist.new
	end

	# GET /artists/1/edit
	def edit
	end

	# POST /artists
	# POST /artists.json
	def create
		@artist = Artist.new(artist_params)

		respond_to do |format|
			if @artist.save 
		  		format.json { render :json => @artist, status: :created }
		  	else
		  		format.json { render json: @artist.errors, status: :unprocessable_entity }
		  	end
		end
	end

	# PATCH/PUT /api/artists/1
  # PATCH/PUT /api/artists/1.json
  def update
		@artist = Artist.find(params[:id])

		respond_to do |format|
      if @artist.update(artist_params)
        format.json { render :json => @artist, status: :ok }
      else
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
	end
	
	# DELETE /api/artists/1
  # DELETE /api/artists/1.json
	def destroy
		@artist = Artist.find(params[:id])
		@artist.destroy
		
    respond_to do |format|
      format.json { render :json => @artist.to_json(only: [:id]) , head: :ok }
    end
  end

	# Never trust parameters from the scary internet, only allow the white list through.
	def artist_params
		params.require(:artist).permit(:id, :firstName, :lastName, :biography, :additionalInfo, :artist_image)
	end

end