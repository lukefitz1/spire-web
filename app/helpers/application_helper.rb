module ApplicationHelper
	def asset_data_base64(path)
	  asset = Rails.application.assets_manifest(path)
	  # asset = CompassRails.sprockets.find_asset(path).to_s
	  throw "Could not find asset '#{path}'" if asset.nil?
	  base64 = Base64.encode64(asset.to_s).gsub(/\s+/, "")
	  "data:#{asset.content_type};base64,#{Rack::Utils.escape(base64)}"
	end
end
