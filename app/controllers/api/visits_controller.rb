class Api::VisitsController < Api::BaseController
  before_action :require_login!

  # GET /api/visits
  # GET /api/visits.json
  def index
    @visits = Visit.all

    respond_to do |format|
			format.json { 
				render :json => @visits
			}
		end
  end

  # GET /visits/1
  # GET /visits/1.json
  def show
    @visits = Visit.find(params[:id])

    respond_to do |format|
			format.json { 
				render :json => @visits
			}
		end
  end

  # # GET /visits/new
  # def new
  #   @visit = Visit.new

  #   if params[:collection_redirect]
  #     session[:coll_redirect] = params[:collection_redirect]
  #   end
  # end

  # # GET /visits/1/edit
  # def edit
  #   if params[:coll_id]
  #     session[:coll_id] = params[:coll_id]
  #   end

  #   if params[:collection_redirect]
  #     session[:coll_redirect] = params[:collection_redirect]
  #   end
  # end

  # POST /api/visits
  # POST /api/visits.json
  def create
    @visit = Visit.new(visit_params)

    respond_to do |format|
      if @visit.save
        format.json { render :json => @visit, status: :created }
      else
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/visits/1
  # PATCH/PUT /api/visits/1.json
  def update
    @visit = Visit.find(params[:id])

    respond_to do |format|
      if @visit.update(visit_params)
        format.json { render :json => @visit, status: :ok }
      else
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # def destroy_visit_from_collection
  #   puts "Redirect? #{visit_params[collection_redirect]}"
  #   puts "Collection ID: #{visit_params[coll_id]}"   
  # end

  # DELETE /api/visits/1
  # DELETE /api/visits/1.json
  def destroy
    @visit = Visit.find(params[:id])
    @visit.destroy

    respond_to do |format|
      format.json { render :json => @visit.to_json(only: [:id]) , head: :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visit
      @visit = Visit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visit_params
      params.require(:visit).permit(:visit_notes, :visit_date_start, :visit_date_end, :collection_id, :coll_id, :collection_redirect)
    end
end
