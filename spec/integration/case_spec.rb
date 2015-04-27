require 'rails_helper'

describe Case do
  context "for an originator" do
    let!(:originator) { create(:practitioner) }
    let!(:recipient) { create(:practitioner) }
    let!(:rcase) { create(:case, originator: originator, recipient: recipient) }

    before :each do
      @rcase = create(:case, originator: originator, recipient: recipient)
      allow(Mailer).to receive(:notification_email).and_return(double(:mailer).as_null_object)
      @rcase.messages << build(:message)
      CaseUpdater.originate(@rcase, double(:request).as_null_object)
      @rcase = Case.find(@rcase.id)
    end

    it "starts off as read" do
      expect(@rcase.unread?(originator)).to be_falsy
    end

    context "when there're replies" do
      before :each do
        reply = create(:message)
        @rcase.messages << reply
        CaseUpdater.reply(@rcase, double(:request).as_null_object)
        @updated_rcase = @rcase.reload
      end

      context "but there're more recent read receipts" do
        it "looks read" do
          ReadReceipt.create(read_case: @updated_rcase, practitioner: originator)
          expect(@updated_rcase.unread?(originator)).to be_falsy
        end
      end

      context "and there're no read receipts" do
        it "looks unread" do
          expect(@updated_rcase.unread?(originator)).to be_truthy
        end
      end

      context "and there are older read receipts" do
        it "looks unread" do
          ReadReceipt.create(read_case: @updated_rcase, practitioner: originator, created_at: 5.minutes.ago)
          expect(@updated_rcase.unread?(originator)).to be_truthy
        end
      end
    end
  end
end

