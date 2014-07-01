require 'spec_helper'

describe PatientsController do
  it "lets the user know that there are no patients" do
    visit patients_path
    expect(page).to have_content "There are no patients yet"
  end

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
    expect(page).to have_content patient.date_of_birth.strftime("%m/%d/%Y")
  end

  it "has a link to create a patient" do
    visit patients_path
    expect(page).to have_link "Add New Patient"
  end

  it "links to the new patient page" do
    visit patients_path
    click_link "Add New Patient"
    expect(current_path).to eq new_patient_path
  end

  it "lists the patients in order by last name" do
    create(:patient, last_name: "Chancellor")
    create(:patient, last_name: "Aronson")
    create(:patient, last_name: "Brown")
    visit patients_path
    expect(all("a.show_patient").map(&:text)).to eq ["Aronson", "Brown", "Chancellor"]
  end

  context "with pagination" do
    it "doesn't have pagination for fewer than 20 records" do
      19.times do
        create(:patient)
      end
      visit patients_path
      expect(page).to_not have_link "Next"
    end

    it "paginates at 20 records" do
      21.times do
        create(:patient)
      end
      visit patients_path
      expect(page).to have_link "Next"
    end
  end
end

