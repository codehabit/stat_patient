class ValueSet
  # TODO: values_for_collection with permanent IDs
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  class << self

    def value_set value_array
      define_singleton_method(:values) do
        value_array.map(&:capitalize)
      end
    end

    def all
      all_set = values.map {|v| self.new(v)}
      all_set.define_singleton_method :decorate do
        all_set
      end
      all_set
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
    other_object.is_a?(self.class) && other_object.value == self.value
  end
end
