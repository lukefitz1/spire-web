class SetOjbIdColumnNotNull < ActiveRecord::Migration[5.1]
  def change
  	change_column :artworks, :ojbId, :string, null: false
  end
end
