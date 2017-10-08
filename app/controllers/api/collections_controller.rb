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

end