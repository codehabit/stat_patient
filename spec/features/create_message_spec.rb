require 'spec_helper'

describe MessagesController do
  xspecify "that a patient can be selected", js: true do
    patient = create(:patient, first_name: "Freda", last_name: "Gonzalez", date_of_birth: 60.years.ago)
    visit new_message_path
    binding.pry
    select2(patient.decorate.full_name_with_dob, from: "Patient")
    click_button "Send"
    visit message_path(Message.first)
    expect(page).to have_content "Sarah Jenkins"
  end
end

