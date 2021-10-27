class Api::MediaController < Api::BaseController
  include ApiSecured
  # before_action :require_login!
  # before_action :authenticate_user!

  # GET /media
  # GET /media.json
  def index
    @media = Medium.all

		respond_to do |format|
			format.json { 
				render :json => @media
			}
		end
  end

  # GET /media/1
  # GET /media/1.json
  # DOESNT WORK YET
  def show
  end

  # GET /media/new
  # DOESNT WORK YET
  def new
    @medium = Medium.new
  end

  # GET /media/1/edit
  # DOESNT WORK YET
  def edit
  end

  # POST /media
  # POST /media.json
  # DOESNT WORK YET
  def create
    @medium = Medium.new(medium_params)

    respond_to do |format|
      if @medium.save
        format.json { render :json => @customer, status: :created }
      else
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media/1
  # PATCH/PUT /media/1.json
  # DOESNT WORK YET
  def update
    respond_to do |format|
      if @medium.update(medium_params)
        format.html { redirect_to @medium, notice: 'Medium was successfully updated.' }
        format.json { render :show, status: :ok, location: @medium }
      else
        format.html { render :edit }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media/1
  # DELETE /media/1.json
  # DOESNT WORK YET
  def destroy
    @medium = Medium.find(params[:id])
    @medium.destroy

    respond_to do |format|
      format.json { render :json => @medium.to_json(only: [:id]) , head: :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medium
      @medium = Medium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medium_params
      params.require(:medium).permit(:media_name, :customer_id)
    end
end
