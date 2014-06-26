require 'spec_helper'

describe PatientsController do
  describe "successful creation" do
    example "with the first and last name" do
      visit new_patient_path
      fill_in "First name", with: "Sally"
      fill_in "Last name", with: "Bongo"
      click_button "Create"
      expect(page).to have_content "Sally Bongo"
    end

    example "with the address" do
      visit new_patient_path
      fill_in "Street Address", with: "123 Main St."
      click_button "Create"
      visit patient_path(Patient.first)
      expect(page).to have_content "123 Main St."
    end

    example "with the date of birth" do
      visit new_patient_path
      find(:css, "[data-unit='day']").set "14"
      find(:css, "[data-unit='month']").set "12"
      find(:css, "[data-unit='year']").set "1974"
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

