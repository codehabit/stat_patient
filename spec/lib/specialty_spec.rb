require 'specialty'

describe Specialty do
  subject {Specialty.new("some stock specialty")}

  context "with draper compatability" do
    it "returns itself on decorate call" do
      expect(subject.decorate).to eq subject
    end

    it "acts like a decorated object" do
      expect(subject.decorate.pretty).to eq "Some stock specialty"
    end

    it "acts like a decorated collection" do
      expect(Specialty.all.decorate).to match_array Specialty.all
    end

    specify "that the id is the underlying value" do
      expect(subject.id).to eq subject.value
    end
  end
  it "is equal" do
    value = "some specialty"
    expect(Specialty.new(value)).to eq Specialty.new(value)
  end
end

