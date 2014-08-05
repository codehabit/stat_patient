require 'spec_helper'

describe PrescriptionOrdersController do

  include_context 'prescription'

  let!(:user) {create(:user)}

  before :each do
    sign_in_as user
    visit prescription_order_path(prescription_order)
  end

  it 'sets the flow status to submitted' do
    select pharmacy.name, from: 'Pharmacy'
    click_button 'Submit'
    expect(prescription_order.reload.flow_status).to eq 'submitted'
  end

  it 'will not allow editing once submitted' do
    select pharmacy.name, from: 'Pharmacy'
    click_button 'Submit'
    visit edit_prescription_order_path(prescription_order)
    expect(current_path).to eq(show_prescription_order_path(prescription_order))
  end

end
