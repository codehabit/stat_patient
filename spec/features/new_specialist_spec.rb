require 'spec_helper'

describe SpecialistsController do
  let!(:user) {create(:user, password: "secret123", password_confirmation: "secret123", email: "me@me.me")}

  before :each do
    sign_in_as(user, "secret123")
  end
  describe 'create specialist' do
    example 'with first last name' do
      visit new_specialist_path
      fill_in "First name", with: "Sam"
      fill_in "Last name", with: "Specialist"
      click_button "Create"
      expect(page).to have_content "Sam Specialist"
    end

    example 'with specialty' do
      visit new_specialist_path
      fill_in "First name", with: "Sam"
      fill_in "Last name", with: "Specialist"
      fill_in 'Specialty', with: 'Endodontist'
      click_button "Create"
      expect(page).to have_content "Endodontist"
    end

    specify 'returns to index' do
      visit new_specialist_path
      fill_in "First name", with: "Sam"
      fill_in "Last name", with: "Specialist"
      fill_in 'Specialty', with: 'Endodontist'
      click_button "Create"
      expect(current_path).to eq specialists_path
    end

  end
  describe "leaving the page" do
    example "by canceling" do
      visit new_specialist_path
      click_link "Cancel"
      expect(current_path).to eq specialists_path
    end
  end

end
