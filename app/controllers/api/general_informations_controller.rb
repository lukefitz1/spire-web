class Api::GeneralInformationsController < Api::BaseController	
	before_action :require_login!

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

  # # GET /general_informations/1
  # # GET /general_informations/1.json
  # def show
  # end

  # # GET /general_informations/new
  # def new
  #   @general_information = GeneralInformation.new
  # end

  # # GET /general_informations/1/edit
  # def edit
  # end

  # # POST /general_informations
  # # POST /general_informations.json
  # def create
  #   @general_information = GeneralInformation.new(general_information_params)

  #   respond_to do |format|
  #     if @general_information.save
  #       format.html { redirect_to @general_information, notice: 'General information was successfully created.' }
  #       format.json { render :show, status: :created, location: @general_information }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @general_information.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /general_informations/1
  # # PATCH/PUT /general_informations/1.json
  # def update
  #   respond_to do |format|
  #     if @general_information.update(general_information_params)
  #       format.html { redirect_to @general_information, notice: 'General information was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @general_information }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @general_information.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

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
      params.require(:general_information).permit(:information_label, :information)
    end
end
