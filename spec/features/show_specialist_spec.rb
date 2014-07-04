require 'spec_helper'

describe SpecialistsController do
  let!(:user) {create(:user)}

  before :each do
    sign_in_as user
  end
  it "links to the show page from the listing page" do
    gretchen = create(:specialist, first_name: "Gretchen", last_name: "Mueller")
    visit specialists_path
    click_link "Gretchen Mueller"
    expect(current_path).to eq specialist_path(gretchen)
  end

  it "shows first name" do
     specialist = create(:specialist, first_name: "Frank")
     visit specialist_path(specialist)
     expect(page).to have_content "Frank"
  end

  it "shows last name" do
     specialist = create(:specialist, last_name: "Sinatra")
     visit specialist_path(specialist)
     expect(page).to have_content "Sinatra"
  end

  it "shows the practice" do
     specialist = create(:specialist, practice_name: "Big Practice")
     visit specialist_path(specialist)
     expect(page).to have_content "Big Practice"
  end

  it "shows the specialty" do
     specialist = create(:specialist, specialty: "Endo")
     visit specialist_path(specialist)
     expect(page).to have_content "Endo"
  end

  it "shows the phone" do
     specialist = create(:specialist, phone: "(773) 478-5555")
     visit specialist_path(specialist)
     expect(page).to have_content "(773) 478-5555"
  end

  it "shows the email" do
     specialist = create(:specialist, email: "johnny@rotten.com")
     visit specialist_path(specialist)
     expect(page).to have_content "johnny@rotten.com"
  end

end

