class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.string :firstName
      t.string :lastName
      t.text :biography

      t.timestamps
    end
  end
end
