require 'spec_helper'

describe PrescriptionOrdersController do

  include_context 'prescription'

  let!(:user) {create(:user)}

  before :each do
    sign_in_as user
    visit prescription_order_path(prescription_order)
  end

  context 'after submitting' do
    before do
      select pharmacy.name, from: 'Pharmacy'
      click_button 'Submit'
    end

    it 'sets the flow status to submitted' do
      expect(prescription_order.reload.flow_status).to eq 'submitted'
    end

    it 'no longer has a submit button' do
      visit prescription_order_path(prescription_order)
      expect(page).to_not have_button 'Submit'
    end

    it 'can no longer be submitted' do
      pending 'insure that the form cannot be re-sent to re-submit the prescription'

      # need a way to PUT
      put submit_prescription_order_path(prescription_order)
      expect(current_path).to eq(prescription_order_path(prescription_order))
    end

    it 'shows "VOID" watermark once submitted so that it cant be reprinted' do
      visit prescription_order_path(prescription_order)
      expect(page).to have_content I18n.t(:copy_watermark, scope: :prescription)
    end

    it 'will not allow editing once submitted' do
      visit edit_prescription_order_path(prescription_order)
      expect(current_path).to eq(prescription_order_path(prescription_order))
    end
  end

end
