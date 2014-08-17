class CreateLabItems < ActiveRecord::Migration
  def change
    create_table :lab_items do |t|
      t.string :name
      t.string :price
      t.string :description
      t.string :item_type
      t.integer :lab_id
      t.timestamps
    end
  end
end
