require 'spec_helper'

describe HomeController do
  let!(:user) {create(:user, password: "secret123", password_confirmation: "secret123", email: "me@me.me")}

  before :each do
    sign_in_as(user, "secret123")
  end
  it "provides a welcome message" do
    visit root_path
    expect(page).to have_content "Welcome to #{AppSettings.title}"
  end

  it "has a link to manage patients" do
    visit root_path
    expect(page).to have_link "Manage Patients"
  end

  it "links to the patients index" do
    visit root_path
    click_link "Manage Patients"
    expect(current_path).to eq patients_path
  end
end

