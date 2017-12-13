class Api::ArtworkController < Api::BaseController	
	before_action :require_login!

	def index
	@artwork = Artwork.all
		respond_to do |format|
			format.json { render :json => @artwork }
		end
	end

	# GET /artworks/1
	# GET /artworks/1.json
	def show
	end

	# GET /artworks/new
	def new
		@artwork = Artwork.new
	end

	# GET /artworks/1/edit
	def edit
	end

	# POST /artworks
	# POST /artworks.json
	def create
		@artwork = Artwork.new(artwork_params)
		cust_id = artwork_params[:customer_id]
		redirect = params[:redirect]

		respond_to do |format|
			if @artwork.save 
		  		format.json { render :json => @artwork, status: :created }
		  	else
		  		format.json { render json: @artwork.errors, status: :unprocessable_entity }
		  	end
		end
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def artwork_params
		params.require(:artwork).permit(:id, :ojbId, :artType, :title, :date, :medium, :image, :description, :dimensions, :frame_dimensions, :condition, :currentLocation, :source, :dateAcquired, :amountPaid, :currentValue, :notes, :notesImage, :additionalInfoLabel, :additionalInfoText, :additionalInfoImage, :additionalPdf, :reviewedBy, :reviewedDate, :provenance, :artist_id, :customer_id, :remove_image, :remove_additionalInfoImage, :remove_notesImage, :collection_id, :dateAcquiredLabel)
	end

end