require 'spec_helper'

describe RegistrationsController, js: true do
  it "creates a practitioner when signing up" do
    visit new_user_registration_path
    fill_in "First name", with: "Alexandria"
    fill_in "Last name", with: "Winters"
    fill_in "Email", with: "valid@valid.com"
    select2("Orthodontics", from: "Specialty")
    fill_in "Password", with: "secret123321"
    fill_in "Password confirmation", with: "secret123321"
    click_button "Sign up"
    visit practitioners_path
    expect(page).to have_content "Alexandria Winters"
  end
end

