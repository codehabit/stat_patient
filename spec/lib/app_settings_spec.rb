require 'spec_helper'

describe AppSettings do
  it "remembers the title" do
    expect(AppSettings.title).to eq "Stat Patient test"
  end
end

