require 'spec_helper'

describe CasesController do
  let!(:practitioner) {create(:practitioner)}
  let!(:user) {create(:user, practitioner: practitioner)}

  before :each do
    sign_in_as user
  end

  xit "lists a message with a patient associated" do
    patient = create(:patient, first_name: "Frank", last_name: "Miller")
    message = create(:message, patient: patient, recipient: practitioner)
    visit messages_path
    expect(page).to have_content "Frank Miller"
  end
end

