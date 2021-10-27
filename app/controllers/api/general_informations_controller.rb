class Api::GeneralInformationsController < Api::BaseController
  include ApiSecured
  # before_action :require_login!
  # before_action :authenticate_user!

  # GET /api/general_informations
  # GET /api/general_informations.json
  def index
    @general_informations = GeneralInformation.all

    respond_to do |format|
      format.json { 
        render :json => @general_informations
      }
    end
  end

  # GET /general_informations/1
  # GET /general_informations/1.json
  def show
    @general_information = GeneralInformation.find(params[:id])

    respond_to do |format|
      format.json { 
        render :json => @general_information
      }
    end
  end

  # # GET /general_informations/new
  # def new
  #   @general_information = GeneralInformation.new
  # end

  # # GET /general_informations/1/edit
  # def edit
  # end

  # POST /api/general_informations
  # POST /api/general_informations.json
  def create
    @general_information = GeneralInformation.new(general_information_params)

    respond_to do |format|
      if @general_information.save 
          format.json { render :json => @general_information, status: :created }
        else
          format.json { render json: @general_information.errors, status: :unprocessable_entity }
        end
    end
  end

  # PATCH/PUT /api/general_informations/1
  # PATCH/PUT /api/general_informations/1.json
  def update
    @general_information = GeneralInformation.find(params[:id])

    respond_to do |format|
      if @general_information.update(general_information_params)
        format.json { render :json => @general_information, status: :ok }
      else
        format.json { render json: @general_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/general_informations/1
  # DELETE /api/general_informations/1.json
  def destroy
    @general_information = GeneralInformation.find(params[:id])
    @general_information.destroy

    respond_to do |format|
      format.json { render :json => @general_information.to_json(only: [:id]) , head: :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_general_information
      @general_information = GeneralInformation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def general_information_params
      params.require(:general_information).permit(:id, :information_label, :information, :created_at, :updated_at)
    end
end
