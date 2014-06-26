require 'spec_helper'

describe PatientsController do
  it "edits first and last name" do
    patient = create(:patient, first_name: "Luis", last_name: "Suarez")
    visit edit_patient_path(patient)
    fill_in "First name", with: "Giorgio"
    fill_in "Last name", with: "Chiellini"
    click_button "Save"
    expect(page).to have_content "Giorgio Chiellini"
    expect(page).to_not have_content "Luis Suarez"
  end

  it "edits the date of birth" do
    patient = create(:patient, first_name: "Luis", last_name: "Suarez")
    visit edit_patient_path(patient)
    find(:css, "[data-unit='day']").set "14"
    find(:css, "[data-unit='month']").set "12"
    find(:css, "[data-unit='year']").set "1974"
    click_button "Save"
    expect(page).to have_content "12/14/1974"
  end
end

