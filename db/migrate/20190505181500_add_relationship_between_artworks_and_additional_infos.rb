class AddRelationshipBetweenArtworksAndAdditionalInfos < ActiveRecord::Migration[5.1]
  def change
  	add_reference :additional_infos, :artworks, type: :uuid, foreign_key: true
  end
end
