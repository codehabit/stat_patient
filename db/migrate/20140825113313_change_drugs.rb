class ChangeDrugs < ActiveRecord::Migration
  def change
    add_column :drugs, :regimen, :string
    add_column :drugs, :dea_schedule, :integer
    add_column :drugs, :category, :string
    rename_column :drugs, :adult_dosing, :strength
    rename_column :drugs, :dosage_forms, :dosage_form
    rename_column :drugs, :patient_instructions, :sig
    rename_column :drugs, :rx_instructions, :instructions_precautions
  end
end
