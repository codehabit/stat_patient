require 'spec_helper'

describe Practitioner do
  it {should have_many :received_cases}
  it {should have_many :received_messages}
  it {should have_many :originations}
  it {should have_many :sent_messages}
end
