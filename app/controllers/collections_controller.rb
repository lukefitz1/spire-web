class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]
  # skip_before_action :pdf_crowd_table
  # skip_before_action :set_collection, only: [:pdf_crowd_table]
  # skip_before_action :require_login!, only: [:pdf_crowd_table]
  before_action :authenticate_user!

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
  def pdf_crowd_table
    @collection = Collection.find(params[:coll_id])

    puts "Collection: #{params[:coll_id]}"
    cookie_name = '_art_collector_web_session'
    cookie_value = cookies[:_art_collector_web_session]
    puts "#{cookie_name}=#{cookie_value}"

    # http://localhost:3000/users/sign_in

    begin
        # create the API client instance
        client = Pdfcrowd::HtmlToPdfClient.new("spireart", "4ca5bdb67c50b7a3ca5d9a207de070e0")
        # client.setHttpAuth("lukefitz1@gmail.com", "pass4luke")
        client.setCookies("_art_collector_web_session=VEh1OEVtRFMxby9nd2dxeDEwWXZLeVhwMFlrOHMzNlAyRkpBM0tYb3FyUXBmRlgwZ3U5aGJpRkNPY0draUEvKzZhMFBUOU5aYWdpNlBBUkttbGgvdTRjcXpXY3ZrL29ETkk1V011ai9IVHdHYkV2WVBXWXZNaEcyOFRWYVNkZjVYMVhPc2Nsc3lSNDNnaXhXU3g4dGNFZEN5UE1iSnhPQUJOQ3d4aURCZ2lLVW5qZFVXdkNRcStTYTNIeW9tcFh2TkdaVzRreE8yaDV2Ynk1TjlwSDdnU1JVYUU2dW5keWduVHJQTWxIY090VT0tLTZ3YUNnQi9pWWMyenU1YXJ6YVd3NWc9PQ%3D%3D--17d5cfcaf0d9484bea841c6bfdd2789a770fd5e2")

        # run the conversion and write the result to a file
        # client.convertUrlToFile("https://spire-art-services.herokuapp.com/collections/pdf_crowd_table/7cb49999-433c-4490-85bc-0e59950f5547?coll_id=b1b51182-33b5-4f31-a546-5073678fe779", 'example.pdf')
        # create output file for conversion result
        output_file = open("example.pdf", "wb")

        # run the conversion and store the result into a pdf variable
        pdf = client.convertUrl("https://spire-art-services.herokuapp.com/collections/pdf_crowd_table/7cb49999-433c-4490-85bc-0e59950f5547?coll_id=b1b51182-33b5-4f31-a546-5073678fe779")

        # write the pdf into the output file
        output_file.write(pdf)

        # close the output file
        output_file.close()
    rescue Pdfcrowd::Error => why
        # report the error
        STDERR.puts "Pdfcrowd Error: #{why}"

        # handle the exception here or rethrow and handle it at a higher level
        raise
    end
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
