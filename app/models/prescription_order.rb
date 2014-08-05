class PrescriptionOrder < ActiveRecord::Base
  belongs_to :pharmacy #, -> { where organization_type: 'pharmacy' }, class_name: 'Organization'
  belongs_to :patient
  belongs_to :practitioner
  belongs_to :practice
  belongs_to :drug

  validates_presence_of :patient, :practitioner, :drug

  def submittable?
    !submitted? && !printed?
  end

  def printable?
    !submitted?
  end

  def submitted?
    self.flow_status == 'submitted'
  end

  def printed?
    self.flow_status == 'printed'
  end
end

