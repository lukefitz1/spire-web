class AddMediaRefToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_reference :media, :customer, type: :uuid, foreign_key: true
  end
end
