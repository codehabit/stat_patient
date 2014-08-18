class ValueSet
  attr_accessor :value

  # so, must:
  # VitaColor.find( 1 ) == <vitacolor value: "B1", id: 1>
  # Vitacolor.all [<a bunch of vita colors>]
  # LabOrder.has_one :vita_color, using vita_color_id
  # Data for VitaColor comes from config/value_sets/vita_color.yml (name assumed)
  # Refer to value objects by ID instead of storing the value. Good infrastructure to have now
  #
  # I guess initialize is needed for referring to vita_color on the show form, index, etc
  # alternatives: 
  # active_hash
  # just make it a *&(&*(#^% active record object and be done with it
  #

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
    self.id
  end

  def find id
    new id
  end

  def ==(other_object)
    other_object.is_a?(self.class) && other_object.value == self.value
  end
end
