class Laboratory
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  class << self
    def all
      values = ["Fred's Retainers", "Back Bay Bite Emporium", "Fischer's Molds, Inc"].map {|v| self.new(v)}
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
    other_object.is_a?(Laboratory) && other_object.value == self.value
  end
end


