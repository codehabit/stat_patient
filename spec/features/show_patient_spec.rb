require 'spec_helper'

describe PatientsController do
  let!(:user) {create(:user)}

  before :each do
    sign_in_as user
  end
  it "links to the show page from the listing page" do
    gretchen = create(:patient, first_name: "Gretchen", last_name: "Mueller")
    visit patients_path
    click_link "Gretchen Mueller"
    expect(current_path).to eq patient_path(gretchen)
  end

  it "shows first name" do
     patient = create(:patient, first_name: "Frank")
     visit patient_path(patient)
     expect(page).to have_content "Frank"
  end

  it "shows last name" do
     patient = create(:patient, last_name: "Sinatra")
     visit patient_path(patient)
     expect(page).to have_content "Sinatra"
  end

  it "shows middle initial" do
     patient = create(:patient, middle_initial: "X")
     visit patient_path(patient)
     expect(page).to have_content "X"
  end

  it "shows the street address" do
     patient = create(:patient, street: "321 Harvard Rd")
     visit patient_path(patient)
     expect(page).to have_content "321 Harvard Rd"
  end

  it "shows the street 2nd line" do
     patient = create(:patient, street2: "Apt 3")
     visit patient_path(patient)
     expect(page).to have_content "Apt 3"
  end

  it "shows the city" do
     patient = create(:patient, city: "Denver")
     visit patient_path(patient)
     expect(page).to have_content "Denver"
  end

  it "shows the state" do
     patient = create(:patient, state: "CO")
     visit patient_path(patient)
     expect(page).to have_content "CO"
  end

  it "shows the home phone" do
     patient = create(:patient, home_phone: "(773) 478-5555")
     visit patient_path(patient)
     expect(page).to have_content "(773) 478-5555"
  end

  it "shows the mobile phone" do
     patient = create(:patient, mobile_phone: "(773) 555-5555")
     visit patient_path(patient)
     expect(page).to have_content "(773) 555-5555"
  end

  it "shows the work phone" do
     patient = create(:patient, work_phone: "(773) 999-5555")
     visit patient_path(patient)
     expect(page).to have_content "(773) 999-5555"
  end

  it "shows the email" do
     patient = create(:patient, email: "johnny@rotten.com")
     visit patient_path(patient)
     expect(page).to have_content "johnny@rotten.com"
  end

  it "shows the gender" do
     patient = create(:patient, gender: "Male")
     visit patient_path(patient)
     expect(page).to have_content "Male"
  end

  it "shows the date of birth" do
     patient = create(:patient, date_of_birth: 30.years.ago)
     visit patient_path(patient)
     expect(page).to have_content 30.years.ago.strftime("%m/%d/%Y")
  end

  it "shows marital status" do
     patient = create(:patient, marital_status: "Married")
     visit patient_path(patient)
     expect(page).to have_content "Married"
  end

  it "shows the SS number" do
     patient = create(:patient, social_security_number: "555-55-5555")
     visit patient_path(patient)
     expect(page).to have_content "555-55-5555"
  end
end

