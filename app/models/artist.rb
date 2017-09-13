class Artist < ApplicationRecord
	require 'csv'

	has_many :artworks

	def self.import(file)
  	# loops through csv data
  	CSV.foreach(file.path, headers:true) do |row|
  		# create new artwork
  		Artist.create! row.to_hash
  	end
  end
end
