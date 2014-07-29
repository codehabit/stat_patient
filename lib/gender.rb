class Gender
  attr_accessor :value
  def initialize(value)
    @value = value
  end

  def self.all
    values = %W{male female}.map {|v| self.new(v)}
    values.define_singleton_method :decorate do
      values
    end
    values
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
