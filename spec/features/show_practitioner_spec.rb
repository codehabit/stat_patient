require 'spec_helper'

describe PractitionersController do
  let!(:user) {create(:user)}

  before :each do
    sign_in_as user
  end
  let(:practice) {create :practice}
  let(:email) {create :contact, :email}
  let(:work_phone) {create :contact, :work_phone }
  let(:addr) {create :address}
  let(:practice) {create :practice}
  let(:practitioner) {create :practitioner, memberships: [practice], contacts: [work_phone, email], addresses: [addr]}

  it "links to the show page from the listing page" do
    visit practitioners_path
    click_link practitioner.full_name
    expect(current_path).to eq practitioner_path(practitioner)
  end

  it "shows first name" do
     visit practitioner_path(practitioner)
     expect(page).to have_content practitioner.first_name
  end

  it "shows last name" do
     visit practitioner_path(practitioner)
     expect(page).to have_content practitioner.last_name
  end

  it "shows the practice" do
     visit practitioner_path(practitioner)
     expect(page).to have_content practice.name
  end

  it "shows the specialty" do
     practitioner = create(:practitioner, specialty: "Endo")
     visit practitioner_path(practitioner)
     expect(page).to have_content "Endo"
  end

  it "shows the phone" do
     visit practitioner_path(practitioner)
     expect(page).to have_content practitioner.work_phone
  end

  it "shows the email" do
     visit practitioner_path(practitioner)
     expect(page).to have_content practitioner.email
  end

  context 'practice info' do
    it 'has the name' do
      visit practitioner_path(practitioner)
      expect(page).to have_content practitioner.memberships.first.name
    end
  end
end
