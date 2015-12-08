require 'spec_helper'


describe PractitionersController do
  let!(:user) {create(:user)}

  before :each do
    sign_in_as user
  end

  let(:practitioner) {create :practitioner}

  let(:new_first_name) {'joe'}
  before do
    visit practitioners_path
    click_link "Edit"
    fill_in 'practitioner_first_name', with: new_first_name
  end

  context 'updating' do
    it 'updates data' do
      click_button 'Update Practitioner'
      expect(page).to have_content new_first_name
    end

    it 'returns to the show page' do
      click_button 'Update Practitioner'
      expect(current_path).to eq practitioner_path(practitioner)
    end
  end

  context 'cancel without saving' do
    it 'does not update data' do
      click_link 'Cancel'
      expect(page).to_not have_content new_first_name
    end

    it 'returns to listing' do
      click_link 'Cancel'
      expect(current_path).to eq practitioners_path
    end
  end
end
