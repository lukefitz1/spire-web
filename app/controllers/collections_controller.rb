class CollectionsController < ApplicationController
  include Secured
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
  def table_of_contents
    @collection = Collection.find(params[:coll_id])
  end

  # GET
  def table_of_contents_pdf
    @collection = Collection.find(params[:coll_id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "toc-pdf",
               template: "collections/table_of_contents_pdf.pdf.erb",
          # orientation: 'Landscape',
               show_as_html: params.key?("debug"),
               encoding: "UTF-8"
      end
    end
  end

  # GET
  def preview_table
    @collection = Collection.find(params[:coll_id])
  end

  # GET
  def download_pdf_table
    begin
      @collection = Collection.find(params[:coll_id])

      # create the API client instance
      client = Pdfcrowd::HtmlToPdfClient.new("spireart", "4ca5bdb67c50b7a3ca5d9a207de070e0")
      client.setCookies("_art_collector_web_session=#{cookies[:_art_collector_web_session]}")
      client.setOrientation("landscape")
      client.setViewport(1400, 768)
      client.setMarginTop("0.1in")
      client.setMarginBottom("0.1in")
      client.setMarginRight("0.1in")
      client.setMarginLeft("0.1in")

      # create output file for conversion result
      output_file = open(Rails.root.join("tmp", "example.pdf"), "wb")

      # run the conversion and store the result into a pdf variable
      pdf = client.convertUrl("https://spire-art-services.herokuapp.com/collections/preview_table/#{params[:id]}?coll_id=#{params[:coll_id]}")

      # write the pdf into the output file
      output_file.write(pdf)

      # download
      send_file("#{Rails.root}/tmp/example.pdf")

      # close the output file
      output_file.close()
    rescue Pdfcrowd::Error => why
      # report the error
      STDERR.puts "Pdfcrowd Error: #{why}"

      # handle the exception here or rethrow and handle it at a higher level
      raise
    end
  end

  def send_that_file
    # download the combined pdf file
    send_file("#{Rails.root}/tmp/example.pdf")
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

  def remove_photos
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
          format.html { redirect_to customer_url(cust_id), notice: "Collection was successfully created." }
          format.json { render :show, status: :created, location: @collection }
        else
          format.html { redirect_to @collection, notice: "Collection was successfully created." }
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
        format.html { redirect_to @collection, notice: "Collection was successfully updated." }
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
      format.html { redirect_to collections_url, notice: "Collection was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def get_bucket_status
    bucket_name = params[:bucketName]
    collection_id = params[:coll_id]

    # Create S3 resource
    s3 = Aws::S3::Client.new(region: ENV.fetch("AWS_REGION"),
                             access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
                             secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"))

    @collection = Collection.find(collection_id)

    resp = s3.list_objects_v2(bucket: bucket_name)
    s3_bucket_length = resp.contents.length
    collection_artworks_length = @collection.artworks.length

    if request.xhr?
      respond_to do |format|
        if s3_bucket_length === collection_artworks_length
          format.json { render json: { response: "good" } }
        else
          format.json { render json: { response: "The number of PDFs in bucket does not match pieces of art in collection" } }
        end
      end
    end
  end

  def download_pdfs_s3
    bucket_name = params[:bucket_name]
    art_array = []
    timestamp = Time.now.strftime("%y%m%d%H%M%S")

    # Create S3 resource
    s3 = Aws::S3::Client.new(region: ENV.fetch("AWS_REGION"),
                             access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
                             secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"))

     # Create S3 resource
    s3_resource = Aws::S3::Resource.new(region: ENV.fetch("AWS_REGION"),
                                        access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
                                        secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"))

    # PASS IN BUCKETNAME TO THIS FUNCTION
    bucket_name = bucket_name
    bucket = s3_resource.bucket(bucket_name)

    # create temp folder for storage
    Dir.mkdir("#{Rails.root}/tmp/#{bucket_name}")

    # Download the files from S3 to a local folder
    resp = s3.list_objects_v2(bucket: bucket_name)
    resp.contents.each do |object|
      art_array.push(object.key)

      file_obj = bucket.object("#{object.key}")
      file_obj.get(response_target: "tmp/#{bucket_name}/#{object.key}")
    end

    # zip up downloads folder
    Zip::File.open("tmp/#{timestamp}_pages.zip", Zip::File::CREATE) do |zipfile|
      art_array.each do |filename|
        zipfile.add(filename, "tmp/#{bucket_name}/#{filename}")
      end
    end

    send_file("#{Rails.root}/tmp/#{timestamp}_pages.zip")

    art_array.each do |filename|
      File.delete("#{Rails.root}/tmp/#{bucket_name}/#{filename}")
    end
    Dir.delete("#{Rails.root}/tmp/#{bucket_name}")
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_collection
    @collection = Collection.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def collection_params
    params.require(:collection).permit(:collectionName, :customer_id, :identifier, :year, { customer_proposals: [] }, { customer_invoices: [] }, { additional_photos: [] }, :remove_customer_proposals, :remove_customer_invoices, { files: [] }, :remove_files)
  end
end
