class CreateCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :collections, id: :uuid do |t|
      t.string :collectionName
      t.references :customer, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
