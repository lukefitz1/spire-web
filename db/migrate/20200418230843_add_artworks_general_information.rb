class AddArtworksGeneralInformation < ActiveRecord::Migration[5.2]
  def change
    create_join_table :general_informations, :artworks, column_options: {type: :uuid} do |t|
      t.index %i[general_information_id artwork_id], unique: true, name: 'index_art_general_infos_on_general_infos_id_and_art_id'
    end

    # migrate artwork to new table
    up_only do
      Artwork.all.each do |a|
        unless a.general_information_id.nil?
          a.update(general_informations: [GeneralInformation.find(a.general_information_id)])
        end
      end
      # drop general_informations from artworks
      # remove_column :artworks, :general_information_id
    end
  end
end
