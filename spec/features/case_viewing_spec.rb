require 'spec_helper'

describe CasesController do
  let!(:practitioner) {create(:practitioner)}
  let(:user) {create(:user, practitioner: practitioner)}

  before :each do
    sign_in_as user
  end

  it "marks a case as read when visited" do
    rcase = create(:case, originator: practitioner, recipient: practitioner, patient: create(:patient), messages: [create(:message)])
    visit polymorphic_path(rcase)
    expect(Case.first).to be_read
  end

  it "disallows visiting a case unless a participant" do
    other_user = create(:user)
    other_practitioner = create(:practitioner, user: other_user)
    other_case = create(:case, recipient: other_practitioner, originator: other_practitioner)
    visit polymorphic_path other_case
    expect(current_path).to eq root_path
  end
end
