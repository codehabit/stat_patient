class CreatePrescriptionOrders < ActiveRecord::Migration
  def change
    create_table :prescription_orders do |t|
      t.integer :patient_id
      t.integer :practitioner_id
      t.integer :drug_id
      t.string :dispense
      t.text :instructions
      t.text :patient_instructions
      t.date :expiration_date
      t.integer :refills
      t.integer :pharmacy_id
      t.timestamps
    end
  end
end
