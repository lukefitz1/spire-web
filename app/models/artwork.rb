class Artwork < ApplicationRecord
  require 'csv'

  belongs_to :artist, optional: true
  belongs_to :customer, optional: true
  belongs_to :collection, optional: true

  mount_uploader :image, ImageUploader
  mount_uploader :notesImage, ImageUploader
  mount_uploader :additionalInfoImage, ImageUploader
  mount_uploader :additionalPdf, PdfUploader

  def self.import(file, customer_id, collection_id)
  	# loops through csv data
  	CSV.foreach(file.path, headers:true) do |row|
  		# create new artwork
      # puts "Customer ID in model: #{customer_id}"
      hash = row.to_hash
      # puts "ORIGINAL: #{hash}"
      hash[:customer_id] = customer_id.to_i
      hash[:collection_id] = collection_id.to_i
      # puts "UPDATED: #{hash}"
      # puts "Customer ID: #{hash['customer']}"

  		Artwork.create! hash
      # Artwork.create! row.to_hash
  	end
  end

  # ORIGINAL IMPORT FUNCTION
  # def self.import(file)
  #   # loops through csv data
  #   CSV.foreach(file.path, headers:true) do |row|
  #     # Artwork.create! row.to_hash
  #   end
  # end

end
