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
    client = Pdfcrowd::PdfToPdfClient.new("lukefitz1", "4340f6a216a4039b0ca0c8035c738f4e")

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

    File.open(Rails.root.join('tmp', "#{timestamp}_#{@artwork[:ojbId]}_#{@artwork[:title]}.pdf")) do |file|
      something = upload.store!(file)
    end

    url = "https://spire-art-bucket-dev.s3.amazonaws.com/uploads/artwork/additionalPdf/#{@artwork[:id]}/#{@artwork[:additionalPdf]}"
    # puts "URL: #{url}"

    # test_url = 'http://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf'
    # additional_pdf = Net::HTTP.get(URI.parse(test_url))
    # puts "Additional PDF: #{additional_pdf}"

    # io     = open('http://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf')
    # reader = PDF::Reader.new(io)
    # puts "Reader page: "
    # puts reader.page(1)


    open('tmp/sample.pdf', 'wb') do |file|
      file << open('http://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf').read
      upload.store!(file)
    end

    client.addPdfFile(Rails.root.join('tmp', "#{timestamp}_#{@artwork[:ojbId]}_#{@artwork[:title]}.pdf"))
    client.addPdfFile(Rails.root.join('tmp', 'sample.pdf'))

    # pdf_data = send_data(additional_pdf, :disposition => 'attachment', :type => "application/pdf")
    # puts "PDF data: #{pdf_data}"
    
    # test_test_pdf = send_data data.read, filename: "test_test.pdf", type: "application/pdf", disposition: 'inline', stream: 'true', buffer_size: '4096' 
    # send_file(test_test_pdf)

    # tried this one, doens't seem to work - combinepdf can't parse the additionalPdf file for some reason
    # pdf << CombinePDF.load(Rails.root.join('tmp', "#{timestamp}_#{@artwork[:ojbId]}_#{@artwork[:title]}.pdf"))
    # pdf << CombinePDF.parse(additional_pdf)

    # tried open-uri here, didn't seem to work either
    # pdf_data = open(test_url).read; nil
    # puts "PDF Data: #{Base64.decode64(pdf_data)}"
    # puts "PDF Data: #{pdf_data}"
    # pdf << CombinePDF.parse(pdf_data); nil

    # save the combined file to the tmp folder (probably can remove this because it wont save anyway) 
    # pdf.save Rails.root.join('tmp', "#{timestamp}_#{@artwork[:ojbId]}_#{@artwork[:title]}.pdf")

    #
    # Trying out PDF crowds beta API 2 that allows for combing pdfs
    #

    # download = open(url)
    # pdf_file = IO.copy_stream(download, "#{@artwork[:additionalPdf]}")
    
    # # configure the conversion
    # client.addPdfFile(Rails.root.join('tmp', "#{timestamp}_#{@artwork[:ojbId]}_#{@artwork[:title]}.pdf"))
    # client.addPdfFile(io)

    # run the conversion and write the result to a file
    client.convertToFile(Rails.root.join('tmp', 'offer.pdf'))
    
    rescue Pdfcrowd::Error => why
    # report the error to the standard error stream
    STDERR.puts "Pdfcrowd Error: #{why}"

    # download the combined pdf file
    send_file("#{Rails.root}/tmp/offer.pdf")

    #
    # Trying out PDF crowds beta API 2 that allows for combing pdfs
    #

    # download the combined pdf file
    # send_file("#{Rails.root}/tmp/#{timestamp}_#{@artwork[:ojbId]}_#{@artwork[:title]}.pdf")
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
