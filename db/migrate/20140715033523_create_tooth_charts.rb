class CreateToothCharts < ActiveRecord::Migration
  def change
    create_table :tooth_charts do |t|
      t.attachment :chart
      t.integer :case_id
    end
  end
end
