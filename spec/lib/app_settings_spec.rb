require 'spec_helper'

describe AppSettings do
  it "remembers the title" do
    expect(Rails).to receive(:env).and_return "test"
    expect(AppSettings.env_title).to eq "Stat Patient test"
  end
end

