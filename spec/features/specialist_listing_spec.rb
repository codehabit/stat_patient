require 'spec_helper'

describe SpecialistsController do

  let(:specialist) {create :specialist}
  let(:specialists) do
    %w(sam dave joe).map do |first_name|
      create :specialist, first_name: first_name
    end
  end

  let(:expected_list_attributes) do
      [
        :first_name,
        :last_name,
        :phone,
        :specialty,
        :practice_name,
        :email
      ]
  end

  context 'when no specialists are defined' do
    it "lets the user know that there are no specialists" do
      visit specialists_path
      expect(page).to have_content I18n.t(:no_specialists)
    end
  end

  describe 'general listing' do
    before do
      specialists
      visit specialists_path
    end

    it 'lists all the specialists' do
      specialists.each do |specialist|
        expect(page).to have_content specialist.first_name
      end
    end
  end

  describe 'basic listing' do
    before do
      specialist
      visit specialists_path
    end

    it "shows one specialist" do
      expect(page).to have_content specialist.first_name
    end

    it 'has expected attrs' do
      expected_list_attributes.each do |attr|
        expect(page).to have_content specialist.send(attr)
      end
    end

  end

  describe 'list actions' do
    let(:create_link) {"#{I18n.t :add_new } #{I18n.t :specialist}"}

    before do
      specialist
      visit specialists_path
    end

    it "has a link to create a specialist" do
      expect(page).to have_link create_link
    end

    it "links to the new patient page" do
      click_link create_link
      expect(current_path).to eq new_specialist_path
    end

    it 'has a link to edit the specialst listed' do
      expect(page).to have_link "#{I18n.t(:edit_specialist)}"
    end
  end
  it "has pagination" do
    21.times do
      create(:specialist)
    end

    visit specialists_path
    expect(page).to have_link "Next"
  end
end

