class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.references :tooth_chart
      t.string :text
      t.integer :height
      t.integer :width
      t.integer :top
      t.integer :left
    end
  end
end
