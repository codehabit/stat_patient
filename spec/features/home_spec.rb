require 'spec_helper'

describe HomeController do
  it "provides a welcome message" do
    visit root_path
    expect(page).to have_content "Welcome to Stat Patient"
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

