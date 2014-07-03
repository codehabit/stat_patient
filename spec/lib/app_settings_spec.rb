require 'spec_helper'

describe AppSettings do
  it "shows the env" do
    Rails.should_receive(:env).and_return "party"
    expect(AppSettings.title).to eq "Stat Patient party"
  end

  it "remembers the title" do
    expect(AppSettings.title).to eq "Stat Patient test"
  end
end

