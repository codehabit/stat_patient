require 'spec_helper'

describe HomeController do
  it "provides a welcome message" do
    visit root_path
    expect(page).to have_content "Welcome to Stat Patient"
  end
end

