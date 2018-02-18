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
  end

  # GET /collections/new
  def new_from_collection
    @artwork = Artwork.new(:customer_id => params[:cust_id], :collection_id => params[:coll_id])
  end

  # GET /artworks/1/edit
  def edit
  end

  # GET artworks/import
  def import
    Artwork.import(params[:file], params[:customer_id], params[:collection_id])

    # after import, redirect to homepage
    redirect_to "/customers/#{params[:customer_id]}", notice: "Data imported successfully!"
  end

  # GET artworks/preview/1
  def preview
    @artwork = Artwork.find(params[:id])
  end

  # GET artworks/preview_pdf/1
  def preview_pdf
    @artwork = Artwork.find(params[:id])
    # puts @artwork

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

    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #     doc2 = @artwork.additionalPdf
    #     puts "Doc 2: #{doc2}"

    #     doc1 = render pdf: 'filename',
    #       template: 'artworks/preview_pdf.pdf.erb',
    #       show_as_html: params.key?('debug'),
    #       encoding: 'UTF-8'
    #     doc = render_to_string(doc1)
    #     doc2 = @artwork.additionalPdf
       

    #     puts "First PDF: #{doc1}, Second PDF: #{doc2}"        
    #     pdf_file = MultipagePdfRenderer.combine([doc1, doc2])
    #     send_data pdf_file, type: 'application/pdf', disposition: 'inline'
    #   end
    # end

    # doc1 = render_to_string(render pdf: 'filename.pdf',
    #                                 template: 'artworks/preview_pdf.pdf.erb')
    # doc2 = render_to_string(@artwork.additionalPdf)
    # pdf_fil = pdf_file = MultipagePdfRenderer.combine([doc1, doc2])
    # send_data pdf_file, type: 'application/pdf', disposition: 'inline'

    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #     # render pdf: "filename_test",
    #     #   template: 'artworks/preview_pdf.pdf.erb',
    #     #   show_as_html: params.key?('debug'),
    #     #   encoding: 'UTF-8',
    #     #   save_to_file: Rails.root.join('public', "test.pdf"),
    #     #   save_only: true

    #       doc2 = Rails.root.join('public', "test.pdf")
    #       doc3 = render_to_string(doc2)

    #       doc1 = @artwork.additionalPdf
    #       pdf_file = MultipagePdfRenderer.combine([doc1, doc2])
    #       send_data pdf_file, type: 'application/pdf', disposition: 'inline'
    #   end
    # end

    url = 'https://spire-art-bucket-dev.s3.amazonaws.com/uploads/artwork/additionalPdf/fe620bd0-d59c-4c29-8dfa-5ab8b709564b/test-pdf-2.pdf'
    resp = Net::HTTP.get_response(URI.parse(url)).body
    pdf = CombinePDF.new
    pdf << CombinePDF.load(Rails.root.join('public', "test.pdf"))
    pdf << CombinePDF.parse(resp)
    pdf.save Rails.root.join('public', 'combined.pdf')
    
    send_file("#{Rails.root}/public/combined.pdf")
  end
  
  # POST /artworks
  # POST /artworks.json
  def create
    @artwork = Artwork.new(artwork_params)
    cust_id = artwork_params[:customer_id]
    redirect = params[:redirect]

    respond_to do |format|
      if @artwork.save
        if redirect
          format.html { redirect_to customer_url(cust_id), notice: 'Artwork was successfully created.' }
          format.json { render :show, status: :created, location: @artwork }
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
    respond_to do |format|
      if @artwork.update(artwork_params)
        format.html { redirect_to @artwork, notice: 'Artwork was successfully updated.' }
        format.json { render :show, status: :ok, location: @artwork }
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
    # puts "Hello"
    puts params[:redirect]
    puts params[:class]
    puts :class

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
      params.require(:artwork).permit(:ojbId, :artType, :title, :date, :medium, :image, :description, :dimensions, :frame_dimensions, :condition, :currentLocation, :source, :dateAcquired, :amountPaid, :currentValue, :notes, :notesImage, :notesImageTwo, :additionalInfoLabel, :additionalInfoText, :additionalInfoImage, :additionalInfoImageTwo, :additionalPdf, :reviewedBy, :reviewedDate, :provenance, :artist_id, :customer_id, :remove_image, :remove_additionalInfoImage, :remove_additionalInfoImageTwo, :remove_notesImage, :remove_notesImageTwo, :collection_id, :dateAcquiredLabel)
    end
end
