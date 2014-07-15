class CreateLaboratoryOrders < ActiveRecord::Migration
  def change
    create_table :laboratory_orders do |t|
      t.integer :patient_id
      t.integer :practitioner_id
      t.integer :laboratory_id
      t.text :requisition
      t.string :vita_number
      t.datetime :due_date
      t.integer :shipping_method_id
      t.text :special_instructions
      t.timestamps
    end
  end
end

