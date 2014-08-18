class LaboratoryOrder < ActiveRecord::Base
  belongs_to :patient
  belongs_to :practitioner
  belongs_to :recipient, polymorphic: true
  belongs_to :visit

  def artifact_type
    "Laboratory Order"
  end

  def subject
    requisition
  end
end

