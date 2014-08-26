class ChangeDrugDiagnosisAssignmentsToUuid < ActiveRecord::Migration
  def change
    add_column :drug_diagnosis_assignments, :drug_uuid, :string
    remove_column :drug_diagnosis_assignments, :drug_id, :integer
  end
end
