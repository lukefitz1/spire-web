class Api::ArtistController < Api::BaseController	
	before_action :require_login!

	def index
	@artist = Artist.all
		respond_to do |format|
			format.json { render :json => @artist }
		end
	end

end