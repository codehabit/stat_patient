require 'spec_helper'

describe LaboratoryOrdersController do
  let!(:lab) {create(:laboratory, name: "Bob Dental Arts")}
  let!(:practitioner) {create(:practitioner)}
  let!(:user) {create(:user, practitioner: practitioner)}

  before :each do
    sign_in_as user
  end

  it "can submit an order", js: true do
    patient = create(:patient, first_name: "David", last_name: "Patterson")
    visit new_laboratory_order_path
    select2 patient.decorate.last_first_with_dob, from: "Patient"
    select2 lab.name, from: "Lab"
    click_button "Create Order"
    expect(page).to have_content lab.name
  end
end

