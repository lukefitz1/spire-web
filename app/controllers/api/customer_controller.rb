class Api::CustomerController < Api::BaseController	
	before_action :require_login!

	def index
	@customer = Customer.all
		respond_to do |format|
			format.json { render :json => @customer }
		end
	end

end