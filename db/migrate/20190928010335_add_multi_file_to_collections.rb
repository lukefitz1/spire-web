class AddMultiFileToColletions < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :files, :json
  end
end
