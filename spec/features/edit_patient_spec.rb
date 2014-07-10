require 'spec_helper'

describe PatientsController do
  let!(:user) {create(:user)}
  let(:patient) { create(:patient, first_name: "Luis", last_name: "Suarez") }

  before :each do
    sign_in_as user
    visit edit_patient_path(patient)
  end

  it "edits first and last name" do
    fill_in "First name", with: "Giorgio"
    fill_in "Last name", with: "Chiellini"
    click_button "Save"
    expect(page).to have_content "Giorgio Chiellini"
    expect(page).to_not have_content "Luis Suarez"
  end

  it "edits the date of birth" do
    find(:css, "[data-unit='day']").set "14"
    find(:css, "[data-unit='month']").set "12"
    find(:css, "[data-unit='year']").set "1974"
    click_button "Save"
    expect(page).to have_content "12/14/1974"
  end

  it "links to the edit patient page" do
    visit patients_path
    click_link "Edit patient"
    expect(current_path).to eq edit_patient_path(patient)
  end

  it "links to a specific patient's edit page" do
    other_patient = create("patient")
    visit patients_path
    within "tr#patient-#{other_patient.id}" do
      click_link "Edit patient"
    end
    expect(current_path).to eq edit_patient_path(other_patient)
  end
end

