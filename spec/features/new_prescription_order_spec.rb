require 'spec_helper'

describe PrescriptionOrdersController do

  describe 'create prescription orders' do
    it 'fills in the current practitioner'
    it 'fills in the current patient'
    it 'adds prompts from the drugs data'
    it 'requires a patient'
    it 'requires a drug'
    it 'requires refills'
    it 'requires patient instructions'
    it 'defaults expired date to 30 days away'
    it 'populates data when a drug is selected'
    it 'allows overwriting drug data'

    it 'saves and redirects to the patient record page'

    specify "prescription practice is the same as the current_user's current_practice"
  end
end
