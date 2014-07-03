require 'spec_helper'

describe MessagesController do
  specify "that a patient can be selected" do
    pending
    visit new_message_path
    fill_in "Select a patient", with: "Sarah"
    select "Sarah Jenkins", from: "[data-role='patient-selector']"
    click_button "Send"
    visit message_path(Message.first)
    expect(page).to have_content "Sarah Jenkins"
  end
end

