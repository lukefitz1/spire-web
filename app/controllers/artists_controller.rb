class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]

  # GET /artists
  # GET /artists.json
  def index
    @artists = Artist.order(:lastName)
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
  end

  # GET /artists/new
  def new
    @artist = Artist.new
  end

  # GET /artists/1/edit
  def edit
  end

  # GET artist/import
  def import_artists
    Artist.import(params[:file])

    # after import, redirect to artists index
    redirect_to artists_url, notice: 'Artist was successfully destroyed.'
  end

  # POST /artists
  # POST /artists.json
  def ajax_create
    match = false

    artists = Artist.all
    artists.each { |artist| 
      if artist_params["firstName"] == artist.firstName
        if artist_params["lastName"] == artist.lastName
          match = true
          break
        end
      end
    }

    if match 
      respond_to do |format|
        format.html { redirect_to new_artist_url, notice: 'Artist already exists' }
      end

    else
      @artist = Artist.new(artist_params)
      @updated_artists = Artist.all

      if request.xhr?
        respond_to do |format|
          if @artist.save
            # format.json { render json: { artists: @updated_artists } }
            format.json { render json: { artists: @updated_artists } }
          else
            format.html { render :new }
            format.json { render json: @artist.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # POST /artists
  # POST /artists.json
  def create
    match = false

    artists = Artist.all
    artists.each { |artist| 
      if artist_params["firstName"] == artist.firstName
        if artist_params["lastName"] == artist.lastName
          match = true
          break
        end
      end
    }

    if match 
      respond_to do |format|
        format.html { redirect_to new_artist_url, notice: 'Artist already exists' }
      end

    else
      @artist = Artist.new(artist_params)

      respond_to do |format|
        if @artist.save
          format.html { redirect_to @artist, notice: 'Artist was successfully created.' }
          format.json { render :show, status: :created, location: @artist }
        else
          format.html { render :new }
          format.json { render json: @artist.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /artists/1
  # PATCH/PUT /artists/1.json
  def update
    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to @artist, notice: 'Artist was successfully updated.' }
        format.json { render :show, status: :ok, location: @artist }
      else
        format.html { render :edit }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artist_params
      params.require(:artist).permit(:firstName, :lastName, :biography, :additionalInfo, :artist_image)
    end
end
