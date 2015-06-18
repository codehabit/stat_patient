class CreatePractitionerPatients < ActiveRecord::Migration
  def change
    create_table :practitioner_patients do |t|
      t.integer :practitioner_id
      t.integer :patient_id
      t.string :timestamps
    end
  end
end
