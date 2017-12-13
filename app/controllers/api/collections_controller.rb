class Api::CollectionsController < Api::BaseController	
	before_action :require_login!

	# GET /collections
    # GET /collections.json
    def index
      @collections = Collection.all

      respond_to do |format|
			format.json { 
				render :json => @collections, :include => { 
					:collection => {}
				} 
			}
		end
    end

	# GET /collections/1
    # GET /collections/1.json
    def show
    	@collection = Collection.find(params[:id])

    	respond_to do |format|
			format.json { render :json => @collection }
		end
    end

	# GET /collections/new
	def new
		@collection = Collection.new
		respond_to do |format|

		end
	end

	# GET /collections/1/edit
    def edit
    end

	# POST /collections
	# POST /collections.json
	def create
		@collection = Collection.new(collection_params)
		cust_id = collection_params[:customer_id]
		redirect = params[:redirect]

		respond_to do |format|
		 	if @collection.save 
		  		format.json { render :json => @collection, status: :created }
		  	else
		  		format.json { render json: @collection.errors, status: :unprocessable_entity }
		  	end
		end
	end

	# Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      	params.require(:collection).permit(:id, :collectionName, :customer_id, :identifier)
    end

end