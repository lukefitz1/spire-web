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

	# Never trust parameters from the scary internet, only allow the white list through.
	def artist_params
		params.require(:artist).permit(:firstName, :lastName, :biography, :additionalInfo)
	end

end