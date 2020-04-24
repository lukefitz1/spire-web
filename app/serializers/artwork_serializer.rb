class ArtworkSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :ojbId, :artType, :title, :date, :medium, :image, :description, :dimensions, :frame_dimensions, :condition, :currentLocation, :source, :dateAcquired, :amountPaid, :currentValue, :notes, :notesImage, :notesImageTwo, :additionalInfoLabel, :additionalInfoText, :additionalInfoImage, :additionalInfoImageTwo, :additionalPdf, :reviewedBy, :reviewedDate, :provenance, :customer_id, :remove_image, :remove_additionalInfoImage, :remove_additionalInfoImageTwo, :remove_notesImage, :remove_notesImageTwo, :collection_id, :dateAcquiredLabel, :remove_additionalPdf, :show_general_info, :include_artist_and_general_info, :custom_title, :general_information_ids, :artist_ids

  belongs_to :customer
  belongs_to :collection
  has_many :artists
  has_many :general_informations
end
