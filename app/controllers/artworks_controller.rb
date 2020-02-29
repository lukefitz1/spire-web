require_relative('../../app/jobs/generate_pdf_job')

class ArtworksController < ApplicationController
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]

  # GET /artworks
  # GET /artworks.json
  def index
    @artworks = Artwork.page(params[:page]).per(10)
  end

  def search
    @artworks = Artwork.joins(:artist).where("concat_ws(' ', \"firstName\", \"lastName\") ILIKE ?", "%#{params[:search]}%").references(:artist)
  end

  # GET /artworks/1
  # GET /artworks/1.json
  def show
  end

  # GET /artworks/new
  def new
    @artwork = Artwork.new
    @artist = Artist.new
    @general_information = GeneralInformation.new

    if params[:collection_redirect]
      session[:coll_redirect] = params[:collection_redirect]
    end
    if params[:customer_redirect]
      session[:cust_redirect] = params[:customer_redirect]
    end
  end

  def preview_html
    @artwork = Artwork.find(params[:id])

    # enqueue our custom job object that uses delayed_job methods
    GeneratePdfJob.perform_later @artwork
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

  def create_bucket(s3_client, bucket_name)
    s3_client.create_bucket(bucket: bucket_name)
  end

  def download_pdfs_background
    customer_id = params[:cust_id]
    collection_id = params[:coll_id]
    timestamp = Time.now.strftime("%y%m%d%H%M%S")
    bucket_name = "#{timestamp}-#{collection_id}"
    collection = Collection.find(collection_id)
    art_array = []
    files_array = []
    @additional_pdf_found = false

    s3 = Aws::S3::Client.new(region: ENV.fetch("AWS_REGION"),
                             access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
                             secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"))
    create_bucket(s3, bucket_name)

    puts bucket_name
    collection.update_attribute(:bucket_name, bucket_name)

    if collection.files?
      collection.files.each do |file|
        if file.identifier.include? "_PDF.pdf"
          files_array.push(file.identifier)
        end
      end
    end

    collection.artworks.each do |art|
      @artwork = Artwork.find(art.id)
      puts "Art ID: #{@artwork.ojbId}"
      temp_art_name = "#{timestamp}_#{@artwork[:ojbId]}_#{@artwork[:title]}.pdf"
      art_file_name = "#{@artwork.ojbId} #{@artwork.artist.firstName} #{@artwork.artist.lastName} (#{@artwork.title}) - #{@artwork.currentLocation}.pdf"
      art_array.push(art_file_name)

      if files_array.include? "#{@artwork.ojbId}_PDF.pdf"
        @additional_pdf_found = true
      else
        @additional_pdf_found = false
      end

       # enqueue our custom job object that uses delayed_job methods
       GeneratePdfJob.perform_later(@artwork, timestamp, bucket_name, temp_art_name, art_file_name, @additional_pdf_found, collection_id)
    end

    respond_to do |format|
      format.html { redirect_to customer_url(customer_id), notice: "PDF Generation was successfully kicked off" }
    end
  end

  # GET artworks/preview_pdf/1
  def download_pdfs
    collection_id = params[:coll_id]
    timestamp = Time.now.strftime("%y%m%d%H%M%S")
    bucket_name = "#{timestamp}-#{collection_id}"
    collection = Collection.find(collection_id)
    puts "User: #{ENV['PDF_CROWD_USER']}, Key: #{ENV['PDF_CROWD_KEY']}"
    client = Pdfcrowd::PdfToPdfClient.new(ENV["PDF_CROWD_USER"], ENV["PDF_CROWD_KEY"])
    art_array = []
    files_array = []
    @additional_pdf_found = false
    ct = 1

    s3 = Aws::S3::Client.new(region: ENV.fetch("AWS_REGION"),
                             access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
                             secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"))
    create_bucket(s3, bucket_name)

    # set timestamp var to nil
    timestamp = nil

    if collection.files?
      collection.files.each do |file|
        if file.identifier.include? "_PDF.pdf"
          files_array.push(file.identifier)
        end
      end
    end

    collection.artworks.each do |art|
      @artwork = Artwork.find(art.id)
      temp_art_name = "#{timestamp}_#{@artwork[:ojbId]}_#{@artwork[:title]}.pdf"
      art_file_name = "#{@artwork.ojbId} #{@artwork.artist.firstName} #{@artwork.artist.lastName} (#{@artwork.title}) - #{@artwork.currentLocation}.pdf"
      art_array.push(art_file_name)

      if files_array.include? "#{@artwork.ojbId}_PDF.pdf"
        @additional_pdf_found = true
      end

      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "artwork_pdf",
                 template: "artworks/preview_pdf.pdf.erb",
                 encoding: "UTF-8",
                 save_to_file: Rails.root.join("tmp", temp_art_name),
                 save_only: true,
                 page_size: "Letter"
        end
      end

      puts "Starting the file reading & joining #{ct}"
      File.open(Rails.root.join("tmp", temp_art_name)) do |file|
        if @artwork[:additionalPdf]
          # check if there is an additional PDF stored with the artwork itself
          url = "https://#{ENV["S3_BUCKET"]}.s3.amazonaws.com/uploads/artwork/additionalPdf/#{@artwork[:id]}/#{@artwork[:additionalPdf]}"
          open(Rails.root.join("tmp", "crossing_fingers.pdf"), "wb") do |file|
            file << open(url).read
    
            open(Rails.root.join("tmp", "template.pdf"), "wb") do |file2|
              file2 << open(Rails.root.join("tmp", temp_art_name)).read
            end
          end
    
          # combine files
          client.addPdfFile(Rails.root.join("tmp", "template.pdf"))
          client.addPdfFile(Rails.root.join("tmp", "crossing_fingers.pdf"))
          
          # run the conversion and write the result to a file
          client.convertToFile("#{Rails.root}/tmp/#{@artwork.ojbId} #{@artwork.artist.firstName} #{@artwork.artist.lastName} (#{@artwork.title}) - #{@artwork.currentLocation}.pdf")

          # clean up some files
          File.delete("#{Rails.root}/tmp/template.pdf") if File.exist?("#{Rails.root}/tmp/template.pdf")
          File.delete("#{Rails.root}/tmp/crossing_fingers.pdf") if File.exist?("#{Rails.root}/tmp/crossing_fingers.pdf")
        elsif @additional_pdf_found
          # check if there is an additional PDF uploaded to the collection
          url = "https://#{ENV["S3_BUCKET"]}.s3.amazonaws.com/uploads/collection/files/#{collection_id}/#{@artwork.ojbId}_PDF.pdf"
          open(Rails.root.join("tmp", "crossing_fingers.pdf"), "wb") do |file|
            file << open(url).read
    
            open(Rails.root.join("tmp", "template.pdf"), "wb") do |file2|
              file2 << open(Rails.root.join("tmp", temp_art_name)).read
            end
          end
    
          # combine files
          client.addPdfFile(Rails.root.join("tmp", "template.pdf"))
          client.addPdfFile(Rails.root.join("tmp", "crossing_fingers.pdf"))

          # run the conversion and write the result to a file
          client.convertToFile("#{Rails.root}/tmp/#{@artwork.ojbId} #{@artwork.artist.firstName} #{@artwork.artist.lastName} (#{@artwork.title}) - #{@artwork.currentLocation}.pdf")

          # clean up some files
          File.delete("#{Rails.root}/tmp/template.pdf") if File.exist?("#{Rails.root}/tmp/template.pdf")
          File.delete("#{Rails.root}/tmp/crossing_fingers.pdf") if File.exist?("#{Rails.root}/tmp/crossing_fingers.pdf")
        else
          open(Rails.root.join("tmp", "#{Rails.root}/tmp/#{@artwork.ojbId} #{@artwork.artist.firstName} #{@artwork.artist.lastName} (#{@artwork.title}) - #{@artwork.currentLocation}.pdf"), "wb") do |file|
            file << open(Rails.root.join("tmp", temp_art_name)).read
          end
        end
      end

      # cleaning up the temp_art_name file
      puts "Deleting temp_art_name file"
      File.delete("#{Rails.root}/tmp/#{temp_art_name}") if File.exist?("#{Rails.root}/tmp/#{temp_art_name}")

      # upload pdf to S3
      puts "upload pdf to S3 #{ct}"
      File.open("#{Rails.root}/tmp/#{art_file_name}", "r") do |final_pdf|
        s3.put_object(bucket: bucket_name, key: art_file_name, body: final_pdf)
      end

      ct += 1
    end

    puts "Settings variables to nil"
    s3 = nil
    collection = nil
    collection_id = nil
    @additional_pdf_found = nil
    @artwork = nil

    # # Create S3 resource
    # s3_resource = Aws::S3::Resource.new(region: ENV.fetch("AWS_REGION"),
    #                                     access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
    #                                     secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"))
    # bucket = s3_resource.bucket(bucket_name)
    #
    # # create temp folder for storage
    # Dir.mkdir("#{Rails.root}/tmp/#{bucket_name}")
    #
    # # Download the files from S3 to a local folder
    # art_array.each do |file_name|
    #   file_obj = bucket.object("#{file_name}")
    #   file_obj.get(response_target: "tmp/#{bucket_name}/#{file_name}")
    # end
    #
    # # zip up downloads folder
    # Zip::File.open("tmp/#{bucket_name}/pages.zip", Zip::File::CREATE) do |zipfile|
    #   art_array.each do |filename|
    #     zipfile.add(filename, "tmp/#{bucket_name}/#{filename}")
    #   end
    # end
    #
    # send_file("#{Rails.root}/tmp/#{bucket_name}/pages.zip")
  end

  # GET artworks/preview_pdf/1
  def preview_pdf
    @artwork = Artwork.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "artwork_pdf",
               template: "artworks/preview_pdf.pdf.erb",
               show_as_html: params.key?("debug"),
               encoding: "UTF-8",
               page_size: "Letter"
      end
    end
  end

  def fancy_report
    puts "Fancy Report!"
    @artwork = Artwork.find(params[:id])
    upload = TempPdfUploader.new
    pdf = CombinePDF.new
    timestamp = Time.now.strftime("%y%m%d%H%M%S")

    # create the API client instance
    puts "User: #{ENV["PDF_CROWD_USER"]}, Key: #{ENV["PDF_CROWD_KEY"]}"
    client = Pdfcrowd::PdfToPdfClient.new(ENV["PDF_CROWD_USER"], ENV["PDF_CROWD_KEY"])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "artwork_pdf",
               template: "artworks/preview_pdf.pdf.erb",
               encoding: "UTF-8",
               save_to_file: Rails.root.join("tmp", "#{timestamp}_#{@artwork[:ojbId]}_#{@artwork[:title]}.pdf"),
               save_only: true,
               page_size: "Letter"
      end
    end

    # create the main template pdf file, save it to tmp directory
    temp_art_name = "#{timestamp}_#{@artwork[:ojbId]}_#{@artwork[:title]}.pdf"
    File.open(Rails.root.join("tmp", temp_art_name)) do |file|
      something = upload.store!(file)
    end

    if !@artwork[:additionalPdf]
      open(Rails.root.join("tmp", "template.pdf"), "wb") do |file2|
        file2 << open(Rails.root.join("tmp", temp_art_name)).read
      end

      client.addPdfFile(Rails.root.join("tmp", "template.pdf"))
    else
      url = "https://#{ENV["S3_BUCKET"]}.s3.amazonaws.com/uploads/artwork/additionalPdf/#{@artwork[:id]}/#{@artwork[:additionalPdf]}"
      open(Rails.root.join("tmp", "crossing_fingers.pdf"), "wb") do |file|
        file << open(url).read

        open(Rails.root.join("tmp", "template.pdf"), "wb") do |file2|
          file2 << open(Rails.root.join("tmp", temp_art_name)).read
        end
      end

      # combine files
      client.addPdfFile(Rails.root.join("tmp", "template.pdf"))
      client.addPdfFile(Rails.root.join("tmp", "crossing_fingers.pdf"))
    end

    # run the conversion and write the result to a file
    client.convertToFile("#{Rails.root}/tmp/#{@artwork.ojbId} #{@artwork.artist.firstName} #{@artwork.artist.lastName} (#{@artwork.title}) - #{@artwork.currentLocation}.pdf")

    # download the combined pdf file
    send_file("#{Rails.root}/tmp/#{@artwork.ojbId} #{@artwork.artist.firstName} #{@artwork.artist.lastName} (#{@artwork.title}) - #{@artwork.currentLocation}.pdf")
  end

  def search_by_objid
    art = Artwork.where(ojbId: params[:objid]).first

    respond_to do |format|
      if art.nil?
        format.json { render json: { "obj_id_exists": false } }
      else
        format.json { render json: { "obj_id_exists": true } }
      end
    end
  end

  # POST /artworks
  # POST /artworks.json
  def create
    @artwork = Artwork.new(artwork_params)
    cust_id = artwork_params[:customer_id]
    coll_id = artwork_params[:collection_id]
    cust_redirect = session[:cust_redirect]
    coll_redirect = session[:coll_redirect]

    respond_to do |format|
      if @artwork.save
        if cust_redirect
          format.html { redirect_to customer_url(cust_id), notice: "Artwork was successfully created." }
          format.json { render :show, status: :created, location: @artwork }
          session.delete(:cust_redirect)
        elsif coll_redirect
          format.html { redirect_to collection_url(coll_id), notice: "Artwork was successfully created." }
          format.json { render :show, status: :created, location: @artwork }
          session.delete(:coll_redirect)
        else
          format.html { redirect_to @artwork, notice: "Artwork was successfully created." }
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
          format.html { redirect_to customer_url(cust_id), notice: "Artwork was successfully updated." }
          format.json { render :show, status: :ok, location: @artwork }
        elsif collection_redirect
          format.html { redirect_to collection_url(coll_id), notice: "Artwork was successfully updated." }
          format.json { render :show, status: :ok, location: @artwork }
          session.delete(:coll_redirect)
        else
          format.html { redirect_to @artwork, notice: "Artwork was successfully updated." }
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
      format.html { redirect_to artworks_url, notice: "Artwork was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    Artwork.destroy(params[:art_ids])
    respond_to do |format|
      format.html { redirect_to artworks_url, notice: "Artworks were successfully deleted" }
      format.json { head :no_content }
    end
  end

  private

  def set_s3_object(filename)
    s3 = Aws::S3::Resource.new(region: ENV.fetch("AWS_REGION"),
                               access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
                               secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"))
    bucket_name = ENV.fetch("S3_BUCKET_PDF")
    @key = filename
    @s3_obj = s3.bucket(bucket_name).object(@key)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_artwork
    @artwork = Artwork.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def artwork_params
    params.require(:artwork).permit(:coll_id, :collection_redirect, :ojbId, :artType, :title, :date, :medium, :image, :description, :dimensions, :frame_dimensions, :condition, :currentLocation, :source, :dateAcquired, :amountPaid, :currentValue, :notes, :notesImage, :notesImageTwo, :additionalInfoLabel, :additionalInfoText, :additionalInfoImage, :additionalInfoImageTwo, :additionalPdf, :reviewedBy, :reviewedDate, :provenance, :artist_id, :customer_id, :remove_image, :remove_additionalInfoImage, :remove_additionalInfoImageTwo, :remove_notesImage, :remove_notesImageTwo, :collection_id, :dateAcquiredLabel, :remove_additionalPdf, :general_information_id, :show_general_info, :custom_title)
  end
end
