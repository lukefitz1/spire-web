class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  # GET /collections
  # GET /collections.json
  def index
    @collections = Collection.all
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/new
  def new_from_customer
    @collection = Collection.new(:customer_id => params[:cust_id])
  end

  # GET 
  def preview_table
    @collection = Collection.find(params[:coll_id])
  end

  # GET
  def pdf_table
    @collection = Collection.find(params[:coll_id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'table-preview',
          template: 'collections/pdf_table.pdf.erb',
          orientation: 'Landscape',
          show_as_html: params.key?('debug'),
          encoding: 'UTF-8'
      end
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
        if redirect
          format.html { redirect_to customer_url(cust_id), notice: 'Collection was successfully created.' }
          format.json { render :show, status: :created, location: @collection }
        else
          format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
          format.json { render :show, status: :created, location: @collection }
        end
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to collections_url, notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      params.require(:collection).permit(:collectionName, :customer_id, :identifier, :year)
    end
end
