require 'spec_helper'


describe SpecialistsController do

  let(:specialist) {create :specialist}

  let(:new_first_name) {'joe'}
  before do
    specialist
    visit specialists_path
    click_link I18n.t(:edit_specialist)
    fill_in 'specialist_first_name', with: new_first_name
  end

  context 'updating' do
    it 'updates data' do
      click_button 'Update Specialist'
      expect(page).to have_content new_first_name
    end

    it 'returns to the listing page' do
      click_button 'Update Specialist'
      expect(current_path).to eq specialists_path
    end
  end

  context 'cancel without saving' do
    it 'does not update data' do
      click_link 'Cancel'
      expect(page).to_not have_content new_first_name
    end

    it 'returns to listing' do
      click_link 'Cancel'
      expect(current_path).to eq specialists_path
    end
  end
end
