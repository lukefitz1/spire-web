class CreateCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :collections do |t|
      t.string :collectionName
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
