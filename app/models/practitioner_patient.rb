class PractitionerPatient < ActiveRecord::Base
  belongs_to :patient
  belongs_to :practitioner
end

