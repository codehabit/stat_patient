class PrescriptionOrder < ActiveRecord::Base
  belongs_to :pharmacy
  belongs_to :patient
  belongs_to :practitioner
  belongs_to :practice
  has_one :drug, foreign_key: :uuid, primary_key: :drug_uuid
  belongs_to :visit

  validates_presence_of :patient, :practitioner, :drug_uuid

  def subject
    drug.name
  end

  def artifact_type
    'Prescription Order'
  end

  def status
    flow_status
  end

  def submittable?
    !submitted? && !printed?
  end

  def printable?
    !submitted?
  end

  def editable?
    submittable?
  end

  def submitted?
    self.flow_status == 'submitted'
  end

  def printed?
    self.flow_status == 'printed'
  end
end

