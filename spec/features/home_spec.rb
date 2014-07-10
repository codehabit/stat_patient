require 'spec_helper'

describe HomeController do
  let!(:user) {create(:user)}

  before :each do
    sign_in_as user
  end

  it "has only one link to manage patients" do
    visit root_path
    expect(all("a", text: "Patients").size).to eq 1
  end

  it "links to the patients index" do
    visit root_path
    click_link "Patients"
    expect(current_path).to eq patients_path
  end
end

