class ArtworksController < ApplicationController
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]

  # GET /artworks
  # GET /artworks.json
  def index
    @artworks = Artwork.all
  end

  # GET /artworks/1
  # GET /artworks/1.json
  def show
  end

  # GET /artworks/new
  def new
    @artwork = Artwork.new
    @artist = Artist.new

    if params[:collection_redirect]
      session[:coll_redirect] = params[:collection_redirect]
      puts "New from Collection IF: #{session[:coll_redirect]}"
    end
  end

  # GET /collections/new
  def new_from_customer_collection
    puts "New from customer collection"

    @artwork = Artwork.new(:customer_id => params[:cust_id], :collection_id => params[:coll_id])
  end

  def new_from_collection
    puts "New from collection"

    @artwork = Artwork.new(:collection_id => params[:coll_id])

    puts "Redirect: #{params[:collection_redirect]}"

    if params[:collection_redirect]
      session[:coll_redirect] = params[:collection_redirect]
      puts "New from Collection IF: #{session[:coll_redirect]}"
    end

  end

  def preview_html
    @artwork = Artwork.find(params[:id])
  end

  # GET /artworks/1/edit
  def edit
    if params[:coll_id]
      session[:coll_id] = params[:coll_id]
    end

    if params[:collection_redirect]
      session[:coll_redirect] = params[:collection_redirect]
    end

  end

  # GET artworks/import
  def import
    Artwork.import(params[:file], params[:customer_id], params[:collection_id])

    if params[:collection_flag]
      # if coming from the collections page, redirect back to collections after the import
      redirect_to "/collections/#{params[:collection_id]}", notice: "Data imported successfully!"
    else
      # redirect to customers page after import
      redirect_to "/customers/#{params[:customer_id]}", notice: "Data imported successfully!"
    end
  end

  # GET artworks/preview/1
  def preview
    @artwork = Artwork.find(params[:id])
  end

  # GET artworks/preview_pdf/1
  def preview_pdf
    @artwork = Artwork.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'filename',
          template: 'artworks/preview_pdf.pdf.erb',
          show_as_html: params.key?('debug'),
          encoding: 'UTF-8'
      end
    end
  end

  def fancy_report
    @artwork = Artwork.find(params[:id])
    upload = TempPdfUploader.new
    pdf = CombinePDF.new
    timestamp = Time.now.strftime("%y%m%d%H%M%S")

    # create the API client instance
    # I currently have 2 different licenses so I can keep getting it fo free
    # client = Pdfcrowd::PdfToPdfClient.new("lukefitz1", "4340f6a216a4039b0ca0c8035c738f4e")
    # client = Pdfcrowd::PdfToPdfClient.new("lukefitz2", "89e129dfaf7246d5c784f3e943bba23f")
    client = Pdfcrowd::PdfToPdfClient.new("spireart", "4ca5bdb67c50b7a3ca5d9a207de070e0")

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'filename',
          template: 'artworks/preview_pdf.pdf.erb',
          encoding: 'UTF-8',
          save_to_file: Rails.root.join('tmp', "#{timestamp}_#{@artwork[:ojbId]}_#{@artwork[:title]}.pdf"),
          save_only: true
      end
    end

    # create the main template pdf file, save it to tmp directory
    temp_art_name = "#{timestamp}_#{@artwork[:ojbId]}_#{@artwork[:title]}.pdf"
    File.open(Rails.root.join('tmp', temp_art_name)) do |file|
      something = upload.store!(file)
    end
   
    if !@artwork[:additionalPdf]
      open(Rails.root.join('tmp', 'template.pdf'), 'wb') do |file2|
        file2 << open(Rails.root.join('tmp', temp_art_name)).read
      end

      client.addPdfFile(Rails.root.join('tmp', 'template.pdf'))
    else
      url = "https://#{ENV["S3_BUCKET"]}.s3.amazonaws.com/uploads/artwork/additionalPdf/#{@artwork[:id]}/#{@artwork[:additionalPdf]}"
      open(Rails.root.join('tmp', 'crossing_fingers.pdf'), 'wb') do |file|
        file << open(url).read

        open(Rails.root.join('tmp', 'template.pdf'), 'wb') do |file2|
          file2 << open(Rails.root.join('tmp', temp_art_name)).read
        end
      end

      # combine files
      client.addPdfFile(Rails.root.join('tmp', 'template.pdf'))
      client.addPdfFile(Rails.root.join('tmp', 'crossing_fingers.pdf'))
    end

    # run the conversion and write the result to a file
    client.convertToFile("#{Rails.root}/tmp/offer.pdf")

    # download the combined pdf file
    send_file("#{Rails.root}/tmp/offer.pdf")
  end
  
  # POST /artworks
  # POST /artworks.json
  def create
    @artwork = Artwork.new(artwork_params)
    cust_id = artwork_params[:customer_id]
    coll_id = artwork_params[:collection_id]

    redirect = params[:redirect]
    coll_redirect = session[:coll_redirect]
    puts "Coll redirect: #{coll_redirect}"

    respond_to do |format|
      if @artwork.save
        if redirect
          format.html { redirect_to customer_url(cust_id), notice: 'Artwork was successfully created.' }
          format.json { render :show, status: :created, location: @artwork }
        elsif coll_redirect
          format.html { redirect_to collection_url(coll_id), notice: 'Artwork was successfully created.' }
          format.json { render :show, status: :created, location: @artwork }
          session[:coll_redirect] = false
        else
          format.html { redirect_to @artwork, notice: 'Artwork was successfully created.' }
          format.json { render :show, status: :created, location: @artwork }
        end
      else
        format.html { render :new }
        format.json { render json: @artwork.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artworks/1
  # PATCH/PUT /artworks/1.json
  def update
    cust_id = artwork_params[:customer_id]
    redirect = params[:redirect]

    coll_id = session[:coll_id]
    collection_redirect = session[:coll_redirect]
    
    respond_to do |format|
      if @artwork.update(artwork_params)

        if redirect
          format.html { redirect_to customer_url(cust_id), notice: 'Artwork was successfully updated.' }
          format.json { render :show, status: :ok, location: @artwork }
        elsif collection_redirect
          format.html { redirect_to collection_url(coll_id), notice: 'Artwork was successfully updated.' }
          format.json { render :show, status: :ok, location: @artwork }
          session[:coll_redirect] = false
        else
          format.html { redirect_to @artwork, notice: 'Artwork was successfully updated.' }
          format.json { render :show, status: :ok, location: @artwork }
        end
      else
        format.html { render :edit }
        format.json { render json: @artwork.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artworks/1
  # DELETE /artworks/1.json
  def destroy
    @artwork.destroy

    respond_to do |format|
      format.html { redirect_to artworks_url, notice: 'Artwork was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artwork
      @artwork = Artwork.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artwork_params
      params.require(:artwork).permit(:coll_id, :collection_redirect, :ojbId, :artType, :title, :date, :medium, :image, :description, :dimensions, :frame_dimensions, :condition, :currentLocation, :source, :dateAcquired, :amountPaid, :currentValue, :notes, :notesImage, :notesImageTwo, :additionalInfoLabel, :additionalInfoText, :additionalInfoImage, :additionalInfoImageTwo, :additionalPdf, :reviewedBy, :reviewedDate, :provenance, :artist_id, :customer_id, :remove_image, :remove_additionalInfoImage, :remove_additionalInfoImageTwo, :remove_notesImage, :remove_notesImageTwo, :collection_id, :dateAcquiredLabel, :remove_additionalPdf)
    end
end
