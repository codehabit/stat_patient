require 'spec_helper'

describe LaboratoryOrdersController do
  let!(:practitioner) {create(:practitioner, first_name: "Marsha", last_name: "Wilson")}
  let!(:user) {create(:user, practitioner: practitioner)}

  before :each do
    sign_in_as user
  end

  xit "has vita color" do
    visit new_laboratory_order_path
    select2 "B1", from: "Vita color"
  end
end

