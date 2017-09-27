class Api::CustomerController < Api::BaseController	
	before_action :require_login!

	# GET /customers
  	# GET /customers.json
	def index
		@customer = Customer.all

		respond_to do |format|
			format.json { 
				render :json => @customer, :include => { 
					:collection => {}
				} 
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

end