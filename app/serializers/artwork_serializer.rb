class ArtworkSerializer < ActiveModel::Serializer
  attributes :id, :ojbId, :artType, :title, :date, :medium, :image, :description, :dimensions, :frame_dimensions, :condition, :currentLocation, :source, :dateAcquired, :amountPaid, :currentValue, :notes, :notesImage, :additionalInfoLabel, :additionalInfoText, :additionalInfoImage, :additionalPdf, :reviewedBy, :reviewedDate, :provenance, :artist_id, :customer_id, :remove_image, :remove_additionalInfoImage, :remove_notesImage, :collection_id, :dateAcquiredLabel, :created_at, :updated_at, :custom_title
end
