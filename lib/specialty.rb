class Specialty
  attr_accessor :value
  def initialize(value)
    @value = value
  end

  def self.all
    specialties = %W{general cosmetics orthodontics periodonticsoral surgery maxillofacial endodontics prosthodontics pediatrics}.map {|v| self.new(v)}
    specialties.define_singleton_method :decorate do
      specialties
    end
    specialties
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

