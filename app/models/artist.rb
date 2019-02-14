class Artist < ApplicationRecord
	require 'csv'

	default_scope { order(firstName: :asc) }

	has_many :artworks

  mount_uploader :artist_image, ImageUploader

	def self.import(file)
  	# loops through csv data
  	CSV.foreach(file.path, headers:true) do |row|
  		# create new artwork
  		Artist.create! row.to_hash
  	end
  end
end
