require 'spec_helper'

describe HomeController do
  let!(:user) {create(:user)}

  before :each do
    sign_in_as user
  end

  it "provides a welcome message" do
    visit root_path
    expect(page).to have_content "Message Center"
  end

  it "has a link to manage patients" do
    visit root_path
    expect(page).to have_link "Patients"
  end

  it "links to the patients index" do
    visit root_path
    click_link "Patients"
    expect(current_path).to eq patients_path
  end
end

