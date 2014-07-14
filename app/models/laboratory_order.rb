class LaboratoryOrder < ActiveRecord::Base
  belongs_to :laboratory, -> { where organization_type: 'laboratory' }, class_name: 'Organization'
  belongs_to :patient
  belongs_to :practitioner
end

