class CreateToothChartMarkings < ActiveRecord::Migration
  def change
    create_table :tooth_chart_markings do |t|
      t.references :tooth_chart, index: true
      t.integer :tooth_id
      t.integer :status_code
      t.string :notes
    end
  end
end
