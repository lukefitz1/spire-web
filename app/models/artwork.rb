class Artwork < ApplicationRecord
  require 'csv'

  default_scope { order(ojbId: :asc) }

  belongs_to :artist, optional: true
  belongs_to :customer, optional: true
  belongs_to :collection, optional: true
  belongs_to :general_information, optional: true

  mount_uploader :image, ImageUploader
  mount_uploader :notesImage, ImageUploader
  mount_uploader :additionalInfoImage, ImageUploader
  mount_uploader :notesImageTwo, ImageUploader
  mount_uploader :additionalInfoImageTwo, ImageUploader
  mount_uploader :additionalPdf, PdfUploader

  validates_uniqueness_of :ojbId

  # has_one :additional_info

  def self.import(file, customer_id, collection_id)
    # loops through csv data
  	CSV.foreach(file.path, headers:true) do |row|
  		# create new artwork
      hash = row.to_hash
      hash[:customer_id] = customer_id
      hash[:collection_id] = collection_id

  		Artwork.create! hash
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
