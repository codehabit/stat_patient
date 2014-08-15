class LaboratoryOrder < ActiveRecord::Base
  belongs_to :laboratory
  belongs_to :patient
  belongs_to :practitioner

  def artifact_type
    "Laboratory Order"
  end

  def subject
    requisition
  end
end

