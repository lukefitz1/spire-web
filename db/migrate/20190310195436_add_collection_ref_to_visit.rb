class AddCollectionRefToVisit < ActiveRecord::Migration[5.1]
  def change
  	add_reference :visits, :collection, type: :uuid, foreign_key: true
  end
end
