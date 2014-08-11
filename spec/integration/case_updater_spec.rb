require 'spec_helper'

describe CaseUpdater do
  describe "adding a participant" do
    it "sends an email notification" do
      rcase = create(:case)
      practice = create(:practice)
      rcase.update(watching_practices: [practice])
      request = double(:request)
      expect(Mailer).to receive(:participant_added_email)
      CaseUpdater.on_participant_added(rcase, request)
    end
  end
end

