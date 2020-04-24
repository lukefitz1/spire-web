class Api::CustomerController < Api::BaseController
  before_action :require_login!

  # GET /api/customers
  # GET /api/customers.json
  def index
    @customer = Customer.all

    respond_to do |format|
      format.json {
        render :json => @customer
      }
    end
  end

  # GET /api/customers/1
  # GET /api/customers/1.json
  def show
    @customer = Customer.find(params[:id])

    respond_to do |format|
      format.json { render :json => @customer }
    end
  end

  # GET /api/customers/new
  def new
    @customer = Customer.new
    respond_to do |format|

    end
  end

  # GET /api/customers/1/edit
  def edit; end

  # POST /api/customers
  # POST /api/customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
          format.json { render :json => @customer, status: :created }
        else
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
    end
  end

  # PATCH/PUT /api/customers/1
  # PATCH/PUT /api/customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update(customer_params)
        format.json { render :json => @customer, status: :ok }
      else
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/customers/1
  # DELETE /api/customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.json { render :json => @customer.to_json(only: [:id]) , head: :ok }
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).permit(:id, :firstName, :lastName, :email_address, :phone_number, :street_address, :city, :state, :zip, :referred_by, :project_notes)
  end

end