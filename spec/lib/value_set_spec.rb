shared_examples  "a value set" do
  let!(:subject_class) {subject.class}
  let(:value) {'xenomorph'}
  context "with draper compatability" do
    it "returns itself on decorate call" do
      expect(subject.decorate).to eq subject
    end

    it "acts like a decorated object" do
      expect(subject.decorate.pretty).to eq value.capitalize
    end

    it "acts like a decorated collection" do
      expect(subject_class.all.decorate).to match_array subject_class.all
    end

    specify "that the id is the underlying value" do
      expect(subject.id).to eq subject.value
    end
  end

  it "is equal" do
    expect(subject_class.new(value)).to eq subject_class.new(value)
  end

  it 'lists all values as pretty' do
    expect(subject_class.values.first).to eq subject_class.values.first.capitalize
  end
end

describe Gender do
  subject {Gender.new(value)}
  it_behaves_like 'a value set'
end

describe Specialty do
  subject {Specialty.new(value)}
  it_behaves_like 'a value set'
end

describe MaritalStatus do
  subject {MaritalStatus.new(value)}
  it_behaves_like 'a value set'
end

describe ShippingMethod do
  subject {ShippingMethod.new(value)}
  it_behaves_like 'a value set'
end

describe VitaColor do
  subject {VitaColor.new(value)}
  it_behaves_like 'a value set'
end
