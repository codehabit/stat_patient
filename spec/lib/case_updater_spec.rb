require 'spec_helper'

describe CaseUpdater do
  let(:request) {double(:request)}
  let(:patient) {create(:patient)}
  let(:originator) {create(:practitioner)}
  let(:recipient) {create(:practitioner)}
  let(:initial_message) {create(:message)}

  before :each do
    allow(Mailer).to receive(:participant_added_email).and_return(double(:mailer, deliver: nil))
    allow(Mailer).to receive(:notification_email).and_return(double(:mailer, deliver: nil))
  end

  context "when originating a case" do
    it "sets the last activity date" do
      rcase = build(:case, patient: patient, originator: originator, recipient: recipient, messages: [initial_message])
      CaseUpdater.originate(rcase, request)
      expect(rcase.last_activity_date).to_not be_nil
    end
  end

  context "when replying to a case" do
    it "sets the last activity date" do
      rcase = create(:case, patient: patient, originator: originator, recipient: recipient, messages: [initial_message])
      CaseUpdater.reply(rcase, request)
      expect(rcase.last_activity_date).to_not be_nil
    end
  end

  context "when adding a participant" do
    it "sets the last activity date" do
      org = create(:practice)
      rcase = create(:case, watching_practices: [org], patient: patient, originator: originator, recipient: recipient, messages: [initial_message])
      CaseUpdater.on_participant_added(rcase, request, org.id)
      expect(rcase.last_activity_date).to_not be_nil
    end
  end
end
