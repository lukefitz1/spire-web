class CreateMedia < ActiveRecord::Migration[5.1]
  def change
    create_table :media, id: :uuid do |t|
      t.string :media_name

      t.timestamps
    end
  end
end
