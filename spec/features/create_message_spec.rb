require 'spec_helper'

describe MessagesController do
  let!(:user) {create(:user, password: "secret123", password_confirmation: "secret123", email: "me@me.me")}

  before :each do
    sign_in_as(user, "secret123")
  end

  xspecify "that a patient can be selected", js: true do
    patient = create(:patient, first_name: "Freda", last_name: "Gonzalez", date_of_birth: 60.years.ago)
    visit new_message_path
    current_path.should == new_message_path
    # select2(patient.decorate.full_name_with_dob, from: "Patient")
    # click_button "Send"
    # visit message_path(Message.first)
    # expect(page).to have_content "Sarah Jenkins"
  end
end

