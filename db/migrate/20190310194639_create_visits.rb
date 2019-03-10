class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits, id: :uuid do |t|
      t.text :visit_notes
      t.date :visit_date_start
      t.date :visit_date_end
      t.references :customer, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
