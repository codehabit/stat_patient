require 'spec_helper'

describe LaboratoryOrdersController do
  let!(:practitioner) {create(:practitioner, first_name: "Marsha", last_name: "Wilson")}
  let!(:user) {create(:user, practitioner: practitioner)}

  before :each do
    sign_in_as user
  end

  it "has vita color", js: true do
    visit new_laboratory_order_path
    select2 "B1", from: "Vita color"
  end

  it "can submit an order", js: true do
    patient = create(:patient)
    visit new_laboratory_order_path
    select2 patient.decorate.last_first_with_dob, from: "Patient"
  end
end

