class AddTimestampsToDrugDiagnosisAssignments < ActiveRecord::Migration
  def change
    add_column :drug_diagnosis_assignments, :created_at, :datetime
    add_column :drug_diagnosis_assignments, :updated_at, :datetime
  end
end
