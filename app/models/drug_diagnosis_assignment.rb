class DrugDiagnosisAssignment < ActiveRecord::Base
  belongs_to :drug

  def drugs diag_id
    where(diagnosis_id: diag_id).drugs
  end
end
