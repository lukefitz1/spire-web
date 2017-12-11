class Api::CustomerController < Api::BaseController	
	before_action :require_login!

	# GET /customers
  	# GET /customers.json
	def index
		@customer = Customer.all

		respond_to do |format|
			format.json { 
				render :json => @customer
			}
		end
	end

	# GET /customers/1
	# GET /customers/1.json
	def show
		@customer = Customer.find(params[:id])

		respond_to do |format|
			format.json { render :json => @customer }
		end
	end

	# GET /customers/new
	def new
		@customer = Customer.new
		respond_to do |format|

		end
	end

	# GET /customers/1/edit
	def edit
	end

	# POST /customers
	# POST /customers.json
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

	# Never trust parameters from the scary internet, only allow the white list through.
	def customer_params
		params.require(:customer).permit(:id, :firstName, :lastName)
	end

end