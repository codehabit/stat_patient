require 'spec_helper'

describe PrescriptionOrdersController do
  include_context 'prescription'

  let!(:user) {create(:user)}

  before :each do
    sign_in_as user
    visit prescription_order_path(prescription_order)
  end

  context 'printed prescription' do
    before do
      click_link 'Print Prescription'
    end
    it 'sets the flow status to "printed"' do
      expect(prescription_order.reload.flow_status).to eq 'printed'
    end

    it 'is no longer submittable' do
      visit prescription_order_path(prescription_order)
      expect(page).to_not have_button 'Submit'
    end

    it 'shows the prescription drug name' do
      expect(page).to have_content prescription_order.drug.name
    end

    it 'will not allow editing once printed' do
      visit edit_prescription_order_path(prescription_order)
      expect(current_path).to eq(prescription_order_path(prescription_order))
    end

    it 'shows "VOID" watermark once so that it cant be reprinted' do
      pending 'verify that this is desired'
      visit prescription_order_path(prescription_order)
      expect(page).to have_content 'VOID'
    end
  end
end
