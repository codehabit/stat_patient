require 'spec_helper'

describe PractitionersController do
  let!(:user) {create(:user)}

  before :each do
    sign_in_as user
  end
  describe 'create practitioner' do
    example 'with first last name' do
      visit new_practitioner_path
      fill_in "First name", with: "Sam"
      fill_in "Last name", with: "Practitioner"
      click_button "Create"
      expect(page).to have_content "Sam Practitioner"
    end

    example 'with specialty' do
      visit new_practitioner_path
      fill_in "First name", with: "Sam"
      fill_in "Last name", with: "Practitioner"
      fill_in 'Specialty', with: 'Endodontist'
      click_button "Create"
      expect(page).to have_content "Endodontist"
    end

    specify 'returns to index' do
      visit new_practitioner_path
      fill_in "First name", with: "Sam"
      fill_in "Last name", with: "Practitioner"
      fill_in 'Specialty', with: 'Endodontist'
      click_button "Create"
      expect(current_path).to eq practitioners_path
    end

  end
  describe "leaving the page" do
    example "by canceling" do
      visit new_practitioner_path
      click_link "Cancel"
      expect(current_path).to eq practitioners_path
    end
  end

end
