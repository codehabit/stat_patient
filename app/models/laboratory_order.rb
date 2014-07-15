class LaboratoryOrder < ActiveRecord::Base
  belongs_to :laboratory
  belongs_to :patient
  belongs_to :practitioner
end

