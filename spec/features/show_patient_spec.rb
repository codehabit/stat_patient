require 'spec_helper'

describe PatientsController do
  let!(:user) {create(:user)}
  let!(:patient) {create(:patient).decorate}

  before :each do
    sign_in_as user
     visit patient_path(patient)
  end
  it "links to the show page from the listing page" do
    click_link patient.full_name
    expect(current_path).to eq patient_path(patient)
  end

  it "shows first name" do
     expect(page).to have_content patient.first_name
  end

  it "shows last name" do
     expect(page).to have_content patient.last_name
  end

  it "shows middle initial" do
     expect(page).to have_content patient.middle_initial
  end

  it "shows the street address" do
     expect(page).to have_content patient.street
  end

  it "shows the street 2nd line" do
     expect(page).to have_content patient.street2
  end

  it "shows the city" do
     expect(page).to have_content patient.city
  end

  it "shows the state" do
     expect(page).to have_content patient.state
  end

  it "shows the home phone" do
     expect(page).to have_content patient.home_phone
  end

  it "shows the mobile phone" do
    expect(page).to have_content patient.mobile_phone
  end

  it "shows the work phone" do
     expect(page).to have_content patient.work_phone
  end

  it "shows the email" do
     expect(page).to have_content patient.email
  end

  it "shows the gender" do
     expect(page).to have_content patient.gender
  end

  it "shows the date of birth" do
     expect(page).to have_content patient.date_of_birth.strftime("%m/%d/%Y")
  end

  it "shows marital status" do
     expect(page).to have_content patient.marital_status
  end

  it "shows the SS number" do
     expect(page).to have_content patient.social_security_number
  end
end

