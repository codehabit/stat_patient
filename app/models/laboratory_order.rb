class LaboratoryOrder < ActiveRecord::Base
  belongs_to :patient
  belongs_to :originator, class_name: Practitioner
  belongs_to :recipient, polymorphic: true
  belongs_to :visit
  has_one :lab_item
  accepts_nested_attributes_for :lab_item

  def artifact_type
    "Laboratory Order"
  end

  def subject
    requisition
  end
end

