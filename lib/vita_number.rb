class VitaNumber
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  class << self
  def all
    values = %w{B1 A1 B2 D2 A2 C1 C2 D4 A3 D3 B3 A3.5 B4 C3 A4 C4 0M1  0M2 0M3}.map {|v| self.new(v)}
    values.define_singleton_method :decorate do
      values
    end
    values
  end
  def values
    all.map(&:value)
  end
  end

  def pretty
    value.capitalize
  end

  def decorate
    self
  end

  def id
    self.value
  end

  def ==(other_object)
    other_object.is_a?(Specialty) && other_object.value == self.value
  end
end


