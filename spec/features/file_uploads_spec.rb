require 'spec_helper'

describe CasesController do
  let!(:practitioner) {create(:practitioner)}
  let!(:user) {create(:user, practitioner: practitioner)}

  before :each do
    sign_in_as user
  end

  xit "can upload a pdf file", js: true do
    visit new_case_path
    attach_file("#file-input", Rails.root.join('spec', 'fixtures', 'images', 'test.pdf'), visible: false)
  end
end

