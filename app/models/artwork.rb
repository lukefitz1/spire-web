class Artwork < ApplicationRecord
  require "csv"

  default_scope { order(ojbId: :asc) }

  belongs_to :artist, optional: true
  belongs_to :customer, optional: true
  belongs_to :collection, optional: true
  belongs_to :general_information, optional: true

  mount_base64_uploader :image, ImageUploader
  mount_base64_uploader :notesImage, ImageUploader
  mount_base64_uploader :notesImageTwo, ImageUploader
  mount_base64_uploader :additionalInfoImage, ImageUploader
  mount_base64_uploader :additionalInfoImageTwo, ImageUploader
  mount_base64_uploader :additionalPdf, PdfUploader

  validates_uniqueness_of :ojbId

  # has_one :additional_info

  def self.import(file, customer_id, collection_id)
    # loops through csv data
    CSV.foreach(file.path, headers: true) do |row|
      # create new artist if the firstName column has info in it
      if row["firstName"]
        new_artist = Artist.create(firstName: row["firstName"], lastName: row["lastName"], biography: row["biography"], additionalInfo: row["additionalInfo"])
      end

      # create new general info if the information_label column has info in it
      if row["information_label"]
        new_general_info = GeneralInformation.create(information_label: row["information_label"], information: row["information"])
      end

      # create new artwork
      hash = row.to_hash
      hash[:customer_id] = customer_id
      hash[:collection_id] = collection_id
      hash[:artist_id] = new_artist.id unless new_artist.nil?
      hash[:general_information_id] = new_general_info.id unless new_general_info.nil?
      hash[:show_general_info] = true unless new_general_info.nil?

      hash.delete("firstName")
      hash.delete("lastName")
      hash.delete("biography")
      hash.delete("additionalInfo")
      hash.delete("information_label")
      hash.delete("information")

      Artwork.create! hash
    end
  end
end
