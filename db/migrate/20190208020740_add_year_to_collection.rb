class AddYearToCollection < ActiveRecord::Migration[5.1]
  def change
    add_column :collections, :year, :string
  end
end
