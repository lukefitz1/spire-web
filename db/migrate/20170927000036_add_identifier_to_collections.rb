class AddIdentifierToCollections < ActiveRecord::Migration[5.1]
  def change
    add_column :collections, :identifier, :string
  end
end
