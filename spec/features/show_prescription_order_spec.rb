require 'spec_helper'

describe PrescriptionOrdersController do
  include_context 'prescription'
  let!(:user) {create(:user)}

  before :each do
    sign_in_as user
    visit prescription_order_path(prescription_order)
  end

  specify 'practitioner should have a practice' do
    expect(practitioner.practices).to eq [practice]
  end

  specify 'practice should have a name' do
    expect(practitioner.practices.first.name).to_not be_nil
  end

  it 'shows the prescription id' do
    expect(page).to have_content prescription_order.rx_id
  end

  it 'has the practitioners practice' do
    expect(page).to have_content practitioner.practices.first.name
  end

  it 'has a print button' do
    expect(page).to have_link 'Print Prescription'
  end

  it 'has a pharmacy selector' do
    select pharmacy.name, from: 'Pharmacy'
  end

  it 'makes the status "printed" after printing' do
    click_link 'Print Prescription'
    expect(prescription_order.reload.flow_status).to eq 'printed'
  end
end
