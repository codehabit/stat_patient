require 'spec_helper'

describe VisitsController do
  describe 'new visits' do
    let!(:patient) {create(:patient).decorate}
    let!(:practice) {create :practice}
    let!(:practitioner) {create :practitioner, memberships: [practice]}

    it 'requires a patient' do
      visit new_visit_path
      select patient, from: 'Patient'
    end

    it 'sets session context for the visit' do
    end

    it 'sets patient context for the visit' do
    end

    it 'references the patient' do
    end

    it 'references the practitioner conducting the visit' do
    end

    it 'confirms the identity of the patient' do
    end

  end

  describe 'affects subsequently created artifacts' do
    it 'connects newly created prescription_orders to the visit' do
    end

    it 'connects newly created prescription_orders to the patient' do
    end
  end

end
