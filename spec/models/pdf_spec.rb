require 'spec_helper'

describe Pdf do
  it "knows its doc type" do
    expect(subject.doc_type).to eq "pdf"
  end
end
