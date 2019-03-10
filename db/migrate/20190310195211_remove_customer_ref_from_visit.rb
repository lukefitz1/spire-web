class RemoveCustomerRefFromVisit < ActiveRecord::Migration[5.1]
  def change
  	remove_reference :visits, :customer, foreign_key: true
  end
end
