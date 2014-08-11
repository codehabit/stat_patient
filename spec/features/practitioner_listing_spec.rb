require 'spec_helper'

describe PractitionersController do
  let!(:user) {create(:user)}

  before :each do
    sign_in_as user
  end

  let(:practitioner) {create :practitioner}
  let(:practitioners) do
    create_list :practitioner, 3
  end

  let(:expected_list_attributes) do
      [
        :first_name,
        :last_name,
        :work_phone,
        :specialty,
        :practice_name,
        :email
      ]
  end

  context 'when no practitioners are defined' do
    it "lets the user know that there are no practitioners" do
      Practitioner.delete_all
      visit practitioners_path
      expect(page).to have_content I18n.t(:no_practitioners)
    end
  end

  describe 'general listing' do
    before do
      practitioners
      visit practitioners_path
    end

    it 'lists all the practitioners' do
      practitioners.each do |practitioner|
        expect(page).to have_content practitioner.first_name
      end
    end
  end

  describe 'basic listing' do
    before do
      practitioner
      visit practitioners_path
    end

    it "shows one practitioner" do
      expect(page).to have_content practitioner.first_name
    end

    it 'has expected attrs' do
      expected_list_attributes.each do |attr|
        expect(page).to have_content practitioner.send(attr)
      end
    end

  end

  describe 'list actions' do
    let(:create_link) {"#{I18n.t :add_new } #{I18n.t :practitioner}"}

    before do
      practitioner
      visit practitioners_path
    end

    it "has a link to create a practitioner" do
      expect(page).to have_link create_link
    end

    it "links to the new patient page" do
      click_link create_link
      expect(current_path).to eq new_practitioner_path
    end

    it 'has a link to edit the specialst listed' do
      expect(page).to have_link "#{I18n.t(:edit_practitioner)}"
    end
  end

  it "has pagination" do
    21.times do
      create(:practitioner)
    end

    visit practitioners_path
    expect(page).to have_link "Next"
  end

  it "orders by practitioner last name" do
    Practitioner.delete_all
    create(:practitioner, first_name: "Ron", last_name: "Chancellor")
    create(:practitioner, first_name: "Ron", last_name: "Aronson")
    create(:practitioner, first_name: "Ron", last_name: "Bronson")
    visit practitioners_path
    expect(all(".show_practitioner").map(&:text)).to eq ["Ron Aronson", "Ron Bronson", "Ron Chancellor"]
  end
end

