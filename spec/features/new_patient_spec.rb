require 'spec_helper'

describe PatientsController do
  let!(:user) {create(:user, password: "secret123", password_confirmation: "secret123", email: "me@me.me")}

  before :each do
    sign_in_as(user, "secret123")
  end

  describe "successful creation" do
    before :each do
      visit new_patient_path
      fill_in "First name", with: "Sally"
      fill_in "Last name", with: "Bongo"
      fill_in "Street address line 1", with: "123 Main st."
      fill_in "City", with: "Smallesville"
      fill_in "State", with: "Ohio"
      fill_in "Zip code", with: "99999"
      fill_in "Home phone", with: "(773) 555-8281"
      find(:css, "[data-unit='day']").set "14"
      find(:css, "[data-unit='month']").set "12"
      find(:css, "[data-unit='year']").set "1974"
      find(:css, "[data-unit='social-pre']").set "000"
      find(:css, "[data-unit='social-mid']").set "00"
      find(:css, "[data-unit='social-suffix']").set "0000"
      choose "Male"
    end

    example "with the first and last name" do
      click_button "Create"
      expect(page).to have_content "Sally Bongo"
    end

    example "with the middle initial" do
      fill_in "Middle initial", with: "X"
      click_button "Create"
      visit patient_path(Patient.first)
      expect(page).to have_content "Sally X Bongo"
    end

    example "with a address line 2" do
      fill_in "Street address line 2", with: "3rd Floor"
      click_button "Create"
      visit patient_path Patient.first
      expect(page).to have_content <<-eos
      123 Main st. 3rd Floor
      Smallesville, Ohio 99999
      eos
    end

    example "with phone numbers" do
      fill_in "Mobile phone", with: "(773) 666-8281"
      fill_in "Work phone", with: "(773) 777-8281"
      click_button "Create"
      visit patient_path Patient.first
      expect(page).to have_content "(773) 555-8281"
      expect(page).to have_content "(773) 666-8281"
      expect(page).to have_content "(773) 777-8281"
    end

    example "with email" do
      fill_in "Email", with: "someone@non.non"
      click_button "Create"
      expect(page).to have_content "someone@non.non"
    end

    example "with gender" do
      click_button "Create"
      visit patient_path(Patient.first)
      expect(page).to have_content "Male"
    end

    example "marital status" do
      choose "Married"
      click_button "Create"
      visit patient_path(Patient.first)
      expect(page).to have_content "Married"
    end

    example "with social security number" do
      click_button "Create"
      visit patient_path(Patient.first)
      expect(page).to have_content "000-00-0000"
    end

    example "with the date of birth" do
      click_button "Create"
      expect(page).to have_content "12/14/1974"
    end
  end

  describe "leaving the page" do
    example "by canceling" do
      visit new_patient_path
      click_link "Cancel"
      expect(current_path).to eq patients_path
    end
  end
end

