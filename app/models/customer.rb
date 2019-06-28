class Customer < ApplicationRecord
	require 'csv'

	has_many :artworks
	has_many :collections
	has_many :media

	mount_uploaders :customer_photos, ImageUploader

	def self.import(file)
		# loops through csv data
		CSV.foreach(file.path, headers:true) do |row|
			# create new artwork
			Customer.create! row.to_hash
		end
	end
end
