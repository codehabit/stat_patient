require 'spec_helper'

describe Patient do
  it {should have_many :messages}
  it {should have_many :images}
end

