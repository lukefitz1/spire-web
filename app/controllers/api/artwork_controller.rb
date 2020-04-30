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
    @artwork = Artwork.find(params[:id])

    respond_to do |format|
      format.json { render :json => @artwork }
    end
  end

  # GET /artworks/new
  def new
    @artwork = Artwork.new
  end

  # GET /artworks/1/edit
  def edit; end

  # POST /artworks
  # POST /artworks.json
  def create
    @artwork = Artwork.new(artwork_params)

    respond_to do |format|
      if @artwork.save
        format.json { render :json => @artwork, status: :created }
      else
        format.json { render json: @artwork.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/artworks/1
  # PATCH/PUT /api/artworks/1.json
  def update
    @artwork = Artwork.find(params[:id])

    respond_to do |format|
      if @artwork.update(artwork_params)
        format.json { render :json => @artwork, status: :ok }
      else
        format.json { render json: @artwork.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/artworks/1
  # DELETE /api/artworks/1.json
  def destroy
    @artwork = Artwork.find(params[:id])
    @artwork.destroy

    respond_to do |format|
      format.json { render :json => @artwork.to_json(only: [:id]) , head: :ok }
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def artwork_params
    params.require(:artwork).permit(:id, :ojbId, :artType, :title, :date, :medium, :image, :description, :dimensions, :frame_dimensions, :condition, :currentLocation, :source, :dateAcquired, :amountPaid, :currentValue, :notes, :notesImage, :notesImageTwo, :additionalInfoLabel, :additionalInfoText, :additionalInfoImage, :additionalInfoImageTwo, :additionalPdf, :reviewedBy, :reviewedDate, :provenance, :artist_id, :customer_id, :remove_image, :remove_additionalInfoImage, :remove_additionalInfoImageTwo, :remove_notesImage, :remove_notesImageTwo, :collection_id, :dateAcquiredLabel, :remove_additionalPdf, :general_information_id, :show_general_info, :custom_title, :include_artist_and_general_info, :custom_artist_label, :custom_details, :provenance_image, :remove_provenance_image, general_information_ids: [], artist_ids: [])
  end

end