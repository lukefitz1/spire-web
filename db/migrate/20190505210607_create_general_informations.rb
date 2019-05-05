class CreateGeneralInformations < ActiveRecord::Migration[5.1]
  def change
    create_table :general_informations, id: :uuid do |t|
      t.string :information_label
      t.text :information

      t.timestamps
    end
  end
end
