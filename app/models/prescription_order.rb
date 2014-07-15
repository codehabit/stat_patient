class PrescriptionOrder < ActiveRecord::Base
  belongs_to :pharmacy #, -> { where organization_type: 'pharmacy' }, class_name: 'Organization'
  belongs_to :patient
  belongs_to :practitioner
  belongs_to :drug

  validates_presence_of :patient, :practitioner, :pharmacy, :drug

  delegate :name, :to => :drug, :prefix => "drug"
  delegate :dispense, :dispense_amount, :dispense_frequency, :adult_dosing, :peds_dosing, :contraindications, :dosage_forms, :pharmacy_instructions, :patient_instructions, to: :drug
end

