class RemoveRelationshipBetweenArtworksAndAdditionalInfos < ActiveRecord::Migration[5.1]
  def change
  	remove_reference :additional_infos, :artworks, foreign_key: true
  end
end
