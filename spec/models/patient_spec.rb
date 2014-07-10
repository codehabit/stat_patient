require 'spec_helper'

describe Patient do
  it {should have_many :cases}
  it {should have_many :images}
  it {should have_many :messages}
end

