class CreateDiagnosisDrugs < ActiveRecord::Migration
  def change
    create_table :drug_diagnosis_assignments do |t|
      t.integer :drug_id
      t.integer :diagnosis_id
    end
  end
end
