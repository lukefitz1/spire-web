class Artwork < ApplicationRecord
  require "csv"

  default_scope { order(ojbId: :asc) }

  attribute :artist_ids
  attribute :general_information_ids

  # belongs_to :artist, optional: true
  # belongs_to :general_information, optional: true
  belongs_to :customer, optional: true
  belongs_to :collection, optional: true
  has_and_belongs_to_many :general_informations, optional: true
  has_and_belongs_to_many :artists, optional: true

  accepts_nested_attributes_for :general_informations

  mount_base64_uploader :image, ImageUploader
  mount_base64_uploader :notesImage, ImageUploader
  mount_base64_uploader :notesImageTwo, ImageUploader
  mount_base64_uploader :additionalInfoImage, ImageUploader
  mount_base64_uploader :additionalInfoImageTwo, ImageUploader
  mount_base64_uploader :provenance_image, ImageUploader
  mount_base64_uploader :additionalPdf, PdfUploader

  validates_uniqueness_of :ojbId

  # has_one :additional_info

  def self.import(file, customer_id, collection_id)
    # loops through csv data
    CSV.foreach(file.path, headers: true) do |row|
      # create new artist if the firstName column has info in it
      if row["Artist First Name"]
        found_artist = Artist.find_by firstName: row["Artist First Name"], lastName: row["Artist Last Name"]
        @artist_for_artwork = found_artist || Artist.create(firstName: row["Artist First Name"], lastName: row["Artist Last Name"], biography: row["biography"], additionalInfo: row["additionalInfo"])
      end

      # create new general info if the information_label column has info in it
      if row["information_label"]
        new_general_info = GeneralInformation.create(information_label: row["information_label"], information: row["information"])
      end

      # create new artwork
      hash = {}
      hash[:customer_id] = customer_id
      hash[:collection_id] = collection_id
      hash[:artist_ids] = @artist_for_artwork.id unless @artist_for_artwork.nil?
      hash[:general_information_id] = new_general_info.id unless new_general_info.nil?
      hash[:show_general_info] = true unless new_general_info.nil?

      # Object ID
      hash[:ojbId] = row["Object ID"]
      # Art Type
      hash[:artType] = row["Art Type"]
      # Title
      hash[:title] = row["Title"]
      # Date
      hash[:date] = row["Date"]
      # Medium
      hash[:medium] = row["Medium"]
      # Description
      hash[:description] = row["Description"]
      # Image	Dimensions
      hash[:dimensions] = row["Dimensions"]
      # Frame Dimensions
      hash[:frame_dimensions] = row["Frame Dimensions"]
      # Condition
      hash[:condition] = row["Condition"]
      # Current Location
      hash[:currentLocation] = row["Current Location"]
      # Source
      hash[:source] = row["Source"]
      # Date Acquired Label
      hash[:dateAcquiredLabel] = row["Date Acquired Label"]
      # Date Acquired
      hash[:dateAcquired] = row["Date Acquired"]
      # Amount Paid
      hash[:amountPaid] = row["Amount Paid"]
      # Current Value
      hash[:currentValue] = row["Current Value"]
      # Notes
      hash[:notes] = row["Notes"]
      # Additional Info Label
      hash[:additionalInfoLabel] = row["Additional Info Label"]
      # Additional Info Text
      hash[:additionalInfoText] = row["Additional Info Text"]
      # Additional PDF
      hash[:additionalPdf] = row["Additional PDF"]
      # Reviewed By
      hash[:reviewedBy] = row["Reviewed By"]
      # Reviewed Date
      hash[:reviewedDate] = row["Reviewed Date"]
      # Provenance
      hash[:provenance] = row["Provenance"]
      # Custom Title
      hash[:custom_title] = row["Custom Title"]
      # Custom Artist Label
      hash[:custom_artist_label] = row["Custom Artist Label"]
      # Custom Details
      hash[:custom_details] = row["Custom Details"]

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
