class PrescriptionOrder < ActiveRecord::Base
  belongs_to :pharmacy #, -> { where organization_type: 'pharmacy' }, class_name: 'Organization'
  belongs_to :patient
  belongs_to :practitioner
  belongs_to :practice
  belongs_to :drug

  validates_presence_of :patient, :practitioner, :drug
end

