class CreateArtworks < ActiveRecord::Migration[5.1]
  def change
    create_table :artworks do |t|
      t.string :ojbId
      t.string :artType
      t.string :title
      t.string :date
      t.string :medium
      t.string :image
      t.text :description
      t.string :dimensions
      t.string :frame_dimensions
      t.string :condition
      t.string :currentLocation
      t.string :source
      t.string :dateAcquired
      t.string :amountPaid
      t.string :currentValue
      t.text :notes
      t.string :notesImage
      t.string :additionalInfoLabel
      t.text :additionalInfoText
      t.string :additionalInfoImage
      t.string :additionalPdf
      t.string :reviewedBy
      t.string :reviewedDate
      t.text :provenance
      t.references :artists, foreign_key: true
      t.references :customers, foreign_key: true

      t.timestamps
    end
  end
end
