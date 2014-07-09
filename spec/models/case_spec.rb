require 'spec_helper'

describe Case do
  it {should belong_to :patient}
  it {should validate_presence_of :recipient}
  it {should validate_presence_of :patient}
  it {should have_many :images}
end

