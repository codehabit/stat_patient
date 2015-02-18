require 'spec_helper'

describe CasesController, js: true do

  let!(:practitioner) {create(:practitioner, first_name: "Marsha", last_name: "Wilson")}
  let!(:user) {create(:user, practitioner: practitioner)}
  let!(:patient) {create(:patient, first_name: "Freda", last_name: "Gonzalez", date_of_birth: 60.years.ago)}

  before :each do
    sign_in_as user
  end

  context "when marking cases as urgent" do
    before :each do
      visit new_case_path
      check "Mark message as urgent"
      select2(patient.decorate.full_name_with_dob, from: "Patient")
      select2(practitioner.decorate.full_name, from: "Recipient")
    end

    specify "that the inbox shows the urgent messages" do
      click_button "Send"
      expect(page).to have_content "Urgent"
    end

    specify "that the show page shows that it's urgent" do
      click_button "Send"
      all("td", text: practitioner.decorate.full_name).first.click
      expect(page).to have_content "Marked urgent"
    end
  end

  context "a successful create" do
    before :each do
      visit new_case_path
      select2(patient.decorate.full_name_with_dob, from: "Patient")
      select2(practitioner.decorate.full_name, from: "Recipient")
      click_button "Send"
    end

    it {expect(current_path).to eq root_path}
  end

  specify "you must select a recipient" do
    visit new_case_path
    click_button "Send"
    page.should have_content "You must select a recipient"
  end

  specify "you must select a patient" do
    visit new_case_path
    click_button "Send"
    page.should have_content "You must select a patient"
  end

  specify "that case number is no longer on the create page" do
    visit new_case_path
    expect(page).to_not have_field "Case number"
  end
end

