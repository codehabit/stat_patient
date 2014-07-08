require 'spec_helper'

describe MessagesController, js: true do

  let!(:practitioner) {create(:practitioner, first_name: "Marsha", last_name: "Wilson")}
  let!(:user) {create(:user, practitioner: practitioner)}

  before :each do
    sign_in_as user
  end

  specify "that a message can be created" do
    patient = create(:patient, first_name: "Freda", last_name: "Gonzalez", date_of_birth: 60.years.ago)
    visit new_message_path
    select2(patient.decorate.full_name_with_dob, from: "Patient")
    select2(practitioner.decorate.full_name, from: "Recipient")
    click_button "Send"
    expect(page).to have_content patient.decorate.full_name
  end

  specify "you must select a recipient" do
    visit new_message_path
    click_button "Send"
    page.should have_content "You must select a recipient"
  end

  specify "you must select a patient" do
    visit new_message_path
    click_button "Send"
    page.should have_content "You must select a patient"
  end
end

