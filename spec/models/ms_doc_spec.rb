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

  it "knows that a pdf is not an MS document" do
    expect(MsDoc.ms_type?("application/pdf")).to eq false
  end

  it "knows whether an .xls doc us a MS document" do
    expect(MsDoc.ms_type?("application/octet-stream")).to eq true
  end

  it "knows whether an .doc doc us a MS document" do
    expect(MsDoc.ms_type?("application/msword")).to eq true
  end

  context "once instantiated" do
    it "knows that it's a power point document" do
      doc = fixture_file_upload(Rails.root.join("spec", "fixtures", "documents", "ppt.pptx"), "application/vnd.openxmlformats-officedocument.presentationml.presentation")
      expect(MsDoc.new(asset: doc).doc_type).to eq "ms_ppt"
    end

    it "knows that it's an excel document" do
      doc = fixture_file_upload(Rails.root.join("spec", "fixtures", "documents", "excel.xlsx"), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
      expect(MsDoc.new(asset: doc).doc_type).to eq "ms_excel"
    end

    it "knows that it's an excel document" do
      doc = fixture_file_upload(Rails.root.join("spec", "fixtures", "documents", "excel.xls"), "application/octet-stream")
      expect(MsDoc.new(asset: doc).doc_type).to eq "ms_excel"
    end

    it "knows that it's a word document" do
      doc = fixture_file_upload(Rails.root.join("spec", "fixtures", "documents", "word.docx"), "application/vnd.openxmlformats-officedocument.wordprocessingml.document")
      expect(MsDoc.new(asset: doc).doc_type).to eq "ms_word"
    end

    it "knows that it's a word document" do
      doc = fixture_file_upload(Rails.root.join("spec", "fixtures", "documents", "word.doc"), "application/msword")
      expect(MsDoc.new(asset: doc).doc_type).to eq "ms_word"
    end
  end
end

