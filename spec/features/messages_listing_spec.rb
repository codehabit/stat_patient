require 'spec_helper'

describe MessagesController do
  it "lists a message" do
    specialist = create(:specialist, first_name: "Todd", last_name: "Johnson")
    patient = create(:patient, first_name: "Frank", last_name: "Miller")
    doctor = create(:user)
    message = create(:message)
    visit messages_path
    expect(page).to have_content "Specialist 1"
  end
end

