require 'value_set'
require 'vita_color'

describe VitaColor do
  describe "the a set" do
    it "has 5 values" do
      expect(VitaColor.a_set.size).to eq 5
    end

    it "doesn't have any b values" do
      letters = VitaColor.a_set.map {|v| v.value.first.downcase}
      expect(letters.include?("b")).to eq false
    end

    it "doesn't have any c values" do
      letters = VitaColor.a_set.map {|v| v.value.first.downcase}
      expect(letters.include?("c")).to eq false
    end

    it "doesn't have any d values" do
      letters = VitaColor.a_set.map {|v| v.value.first.downcase}
      expect(letters.include?("d")).to eq false
    end
  end

  describe "the b set" do
    it "has 4 values" do
      expect(VitaColor.b_set.size).to eq 4
    end

    it "doesn't have any a values" do
      letters = VitaColor.b_set.map {|v| v.value.first.downcase}
      expect(letters.include?("a")).to eq false
    end

    it "doesn't have any c values" do
      letters = VitaColor.b_set.map {|v| v.value.first.downcase}
      expect(letters.include?("c")).to eq false
    end

    it "doesn't have any d values" do
      letters = VitaColor.b_set.map {|v| v.value.first.downcase}
      expect(letters.include?("d")).to eq false
    end
  end

  describe "the c set" do
    it "has 4 values" do
      expect(VitaColor.c_set.size).to eq 4
    end

    it "doesn't have any a values" do
      letters = VitaColor.c_set.map {|v| v.value.first.downcase}
      expect(letters.include?("a")).to eq false
    end

    it "doesn't have any b values" do
      letters = VitaColor.c_set.map {|v| v.value.first.downcase}
      expect(letters.include?("b")).to eq false
    end

    it "doesn't have any d values" do
      letters = VitaColor.c_set.map {|v| v.value.first.downcase}
      expect(letters.include?("d")).to eq false
    end
  end

  describe "the d set" do
    it "has 4 values" do
      expect(VitaColor.d_set.size).to eq 3
    end

    it "doesn't have any a values" do
      letters = VitaColor.d_set.map {|v| v.value.first.downcase}
      expect(letters.include?("a")).to eq false
    end

    it "doesn't have any b values" do
      letters = VitaColor.d_set.map {|v| v.value.first.downcase}
      expect(letters.include?("b")).to eq false
    end

    it "doesn't have any c values" do
      letters = VitaColor.d_set.map {|v| v.value.first.downcase}
      expect(letters.include?("c")).to eq false
    end
  end
end

