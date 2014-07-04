require 'spec_helper'

describe MessagesController do
  let!(:user) {create(:user, password: "secret123", password_confirmation: "secret123", email: "me@me.me")}

  before :each do
    sign_in_as(user, "secret123")
  end

  xit "lists a message with a patient associated" do
    patient = create(:patient, first_name: "Frank", last_name: "Miller")
    message = create(:message, patient: patient)
    visit messages_path
    expect(page).to have_content "Frank Miller"
  end
end

