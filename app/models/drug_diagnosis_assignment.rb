class DrugDiagnosisAssignment < ActiveRecord::Base
  has_one :drug, foreign_key: :uuid, primary_key: :drug_uuid
end
