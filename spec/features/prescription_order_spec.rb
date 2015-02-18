require 'spec_helper'

describe PrescriptionOrdersController, js:true do

  let!(:drug) {create :drug }
  let!(:practice) {create :practice}
  let!(:practitioner) {create :practitioner , memberships: [practice]}
  let!(:user) {create :user, practitioner: practitioner }
  # let!(:patient) {create :patient }
  let!(:patient) {create(:patient, first_name: "Freda", last_name: "Gonzalez", date_of_birth: 60.years.ago)}

  before :each do
    sign_in_as user
  end

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


  context 'with no active visit' do

    it 'saves' do
      visit new_prescription_order_path
      select2(patient.decorate.last_first_with_dob, from: "Patient")
      select2(drug.name, from: "Rx")
      click_button I18n.t(:submit, scope: :prescription)
      expect(current_path).to eq prescription_orders_path
    end

    it 'lists the prescription' do
      pending 'select2 helper does not work'
      visit new_prescription_order_path
      select2(patient.decorate.full_name_with_dob, from: "Patient")
      select2(drug.name, from: "Rx")
      click_button I18n.t(:submit, scope: :prescription)
      expect(page).to have_content drug.name
    end

  end
  describe 'printing prescription' do
    it 'does not allow modification after printing'
  end
end
