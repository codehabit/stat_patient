require 'spec_helper'

describe PatientsController do
  it "lists 1 patient" do
    patient = create(:patient, first_name: "Guillermo")
    visit patients_path
    expect(page).to have_content patient.first_name
  end

  it "lists many patients" do
    names = %W{fred sally ruby john}
    names.each do |name|
      create(:patient, first_name: name)
    end
    visit patients_path
    names.each do |name|
      expect(page).to have_content name
    end
  end

  it "lists each patient's last name" do
    patient = create(:patient, last_name: "Ochoa")
    visit patients_path
    expect(page).to have_content patient.last_name
  end

  it "lists each patient's date of birth" do
    patient = create(:patient, date_of_birth: 29.years.ago)
    visit patients_path
    expect(page).to have_content patient.date_of_birth
  end
end

