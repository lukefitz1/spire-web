class Artwork < ApplicationRecord
  require 'csv'

  belongs_to :artist, optional: true
  belongs_to :customer, optional: true

  mount_uploader :image, ImageUploader
  mount_uploader :notesImage, ImageUploader
  mount_uploader :additionalInfoImage, ImageUploader

  def self.import(file)
  	# loops through csv data
  	CSV.foreach(file.path, headers:true) do |row|
  		# create new artwork
  		Artwork.create! row.to_hash
  	end
  end

end
