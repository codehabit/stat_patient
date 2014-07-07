require 'spec_helper'

describe Message do
  it {should belong_to :patient}
  it {should validate_presence_of :recipient}
end

