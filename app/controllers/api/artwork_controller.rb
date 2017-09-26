class Api::ArtworkController < Api::BaseController	
	before_action :require_login!

	def index
	@artwork = Artwork.all
		respond_to do |format|
			format.json { render :json => @artwork }
		end
	end

end