require 'specialty'
require 'spec_helper'

describe SpecialtyDecorator do
  it "makes pretty values" do
    expect(Specialty.new("lower case specialty").decorate).to eq "Lower case specialty"
  end
end

