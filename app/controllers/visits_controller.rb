class VisitsController < ApplicationController
  before_action :set_visit, only: [:show, :edit, :update, :destroy]

  # GET /visits
  # GET /visits.json
  def index
    @visits = Visit.all
  end

  # GET /visits/1
  # GET /visits/1.json
  def show
  end

  # GET /visits/new
  def new
    @visit = Visit.new

    if params[:collection_redirect]
      session[:coll_redirect] = params[:collection_redirect]
    end
  end

  # GET /visits/1/edit
  def edit
    if params[:coll_id]
      session[:coll_id] = params[:coll_id]
    end

    if params[:collection_redirect]
      session[:coll_redirect] = params[:collection_redirect]
    end
  end

  # POST /visits
  # POST /visits.json
  def create
    @visit = Visit.new(visit_params)
    coll_id = visit_params[:collection_id]
    coll_redirect = session[:coll_redirect]

    respond_to do |format|
      if @visit.save
        if coll_redirect
          format.html { redirect_to collection_url(coll_id), notice: 'Visit was successfully created.' }
          format.json { render :show, status: :created, location: @visit }
          session.delete(:coll_redirect)
        else
          format.html { redirect_to @visit, notice: 'Visit was successfully created.' }
          format.json { render :show, status: :created, location: @visit }
        end
      else
        format.html { render :new }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visits/1
  # PATCH/PUT /visits/1.json
  def update
    coll_id = session[:coll_id]
    collection_redirect = session[:coll_redirect]

    respond_to do |format|
      if @visit.update(visit_params)
        if collection_redirect
          format.html { redirect_to collection_url(coll_id), notice: 'Visit was successfully updated.' }
          format.json { render :show, status: :ok, location: @visit }
          session.delete(:coll_redirect)
        else
          format.html { redirect_to @visit, notice: 'Visit was successfully updated.' }
          format.json { render :show, status: :ok, location: @visit }
        end
      else
        format.html { render :edit }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_visit_from_collection
    puts "Redirect? #{visit_params[collection_redirect]}"
    puts "Collection ID: #{visit_params[coll_id]}"   
  end

  # DELETE /visits/1
  # DELETE /visits/1.json
  def destroy
    puts "Collection ID: #{params[:coll_id]}"
    puts "Redirect: #{params[:collection_redirect]}"

    @visit.destroy
    respond_to do |format|
      if params[:collection_redirect]
        format.html { redirect_to collection_url(params[:coll_id]), notice: 'Visit was successfully destroyed.' }
        format.json { render :show, status: :ok, location: @visit }
      else
        format.html { redirect_to visits_url, notice: 'Visit was successfully destroyed.' }
        format.json { head :no_content }
      end
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
