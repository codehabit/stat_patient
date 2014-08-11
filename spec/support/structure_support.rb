RSpec.shared_context "practice", :a => :b do
  let(:email) {create :contact, :email}
  let(:work_phone) {create :contact, :work_phone }
  let(:addr) {create :address}
  let(:practice) {create :practice, contacts: [work_phone, email], addresses: [addr]}
  let!(:practitioner) {create :practitioner, practices: [practice]}
end

RSpec.shared_context "patient", :a => :b do
  let!(:patient) {create :patient}
end

RSpec.shared_context "prescription", :a => :b do
  include_context "practice"
  include_context "patient"
  let!(:pharmacy) {create(:pharmacy)}
  let(:drug) {create(:drug)}
  let!(:prescription_order) {create(:prescription_order, practice: practice, drug: drug, patient: patient, practitioner: practitioner)}
end
