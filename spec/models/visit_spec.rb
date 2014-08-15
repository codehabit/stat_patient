require 'spec_helper'

describe Visit do
  it {should have_many(:visit_artifact_attachments)}
  # it 'has artifacts' do
  #   visit = create :visit
  #   a_case = create :case
  #   visit.artifacts << a_case
  #   expect(visit).to have:tab


  # end
end
