require 'spec_helper'

describe MsDoc do
  it "knows whether a ppt doc an MS document" do
    expect(MsDoc.ms_type?("application/vnd.openxmlformats-officedocument.presentationml.presentation")).to_not eq false
  end

  it "knows whether a word doc is an MS document" do
    expect(MsDoc.ms_type?("application/vnd.openxmlformats-officedocument.wordprocessingml.document")).to_not eq false
  end

  it "knows whether a excel doc is an MS document" do
    expect(MsDoc.ms_type?("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")).to_not eq false
  end

  it "knows whether an .xls doc us a MS document" do
    expect(MsDoc.ms_type?("application/octet-stream")).to eq true
  end

  it "knows whether an .doc doc us a MS document" do
    expect(MsDoc.ms_type?("application/msword")).to eq true
  end
end

