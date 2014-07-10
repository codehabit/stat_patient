require 'spec_helper'

describe PractitionersController do
  let!(:user) {create(:user)}

  before :each do
    sign_in_as user
  end
  it "links to the show page from the listing page" do
    gretchen = create(:practitioner, first_name: "Gretchen", last_name: "Mueller")
    visit practitioners_path
    click_link "Gretchen Mueller"
    expect(current_path).to eq practitioner_path(gretchen)
  end

  it "shows first name" do
     practitioner = create(:practitioner, first_name: "Frank")
     visit practitioner_path(practitioner)
     expect(page).to have_content "Frank"
  end

  it "shows last name" do
     practitioner = create(:practitioner, last_name: "Sinatra")
     visit practitioner_path(practitioner)
     expect(page).to have_content "Sinatra"
  end

  it "shows the practice" do
     practitioner = create(:practitioner, practice_name: "Big Practice")
     visit practitioner_path(practitioner)
     expect(page).to have_content "Big Practice"
  end

  it "shows the specialty" do
     practitioner = create(:practitioner, specialty: "Endo")
     visit practitioner_path(practitioner)
     expect(page).to have_content "Endo"
  end

  it "shows the phone" do
     practitioner = create(:practitioner, phone: "(773) 478-5555")
     visit practitioner_path(practitioner)
     expect(page).to have_content "(773) 478-5555"
  end

  it "shows the email" do
     practitioner = create(:practitioner, email: "johnny@rotten.com")
     visit practitioner_path(practitioner)
     expect(page).to have_content "johnny@rotten.com"
  end

end

