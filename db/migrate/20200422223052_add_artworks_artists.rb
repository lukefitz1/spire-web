class AddArtworksArtists < ActiveRecord::Migration[5.2]
  def change
    create_join_table :artists, :artworks, column_options: {type: :uuid} do |t|
      t.index %i[artist_id artwork_id], unique: true
    end

    # migrate artwork to new table
    up_only do
      Artwork.all.each do |a|
        unless a.artist_id.nil?
          a.update(artists: [Artist.find(a.artist_id)])
        end
      end
      # drop artist from artworks
      # remove_column :artworks, :artist_id
    end
  end
end
