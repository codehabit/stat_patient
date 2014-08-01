require 'spec_helper'

describe CasesController do
  let!(:practitioner) {create(:practitioner)}
  let(:user) {create(:user, practitioner: practitioner)}
  let(:rcase) {create(:case, originator: practitioner, recipient: practitioner, patient: create(:patient), messages: [create(:message, sender: practitioner)])}

  before :each do
    sign_in_as user
  end

  it "marks a case as read when visited" do
    visit polymorphic_path(rcase)
    visit root_path
    expect(page).to_not have_content("Unread")
  end

  it "disallows visiting a case unless a participant" do
    other_user = create(:user)
    other_practitioner = create(:practitioner, user: other_user)
    other_case = create(:case, recipient: other_practitioner, originator: other_practitioner)
    visit polymorphic_path other_case
    expect(current_path).to eq root_path
  end

  describe "adding participants" do
    example "a practitioner can be added to a case" do
      participant = create(:practitioner, first_name: "Wally", last_name: "Winters")
      visit polymorphic_path(rcase)
      select2 "Wally Winters", from: "Add a participant"
      click_button "Send"
      expect(page).to have_content "Wally Winters was added to the conversation"
    end
  end
end
