require 'spec_helper'

describe Practitioner do
  it {should have_many :received_cases}
  it {should have_many :received_messages}
  it {should have_many :originations}
  it {should have_many :sent_messages}

  it "has involved cases" do
    sender = create(:practitioner)
    recipient = create(:practitioner)
    rcase = create(:case, originator: sender, recipient: recipient)
    expect(recipient.involved_cases).to eq [rcase]
    expect(sender.involved_cases).to eq [rcase]
  end
end

