class CreateDrugs < ActiveRecord::Migration
  def change
    create_table :drugs do |t|
      t.string :name
      t.string :dispense_amount
      t.string :dispense_frequency
      t.string :uuid
      t.text :adult_dosing
      t.text :peds_dosing
      t.text :contraindications
      t.text :dosage_forms
      t.text :pharmacy_instructions
      t.text :patient_instructions
      t.timestamps
    end
  end
end
