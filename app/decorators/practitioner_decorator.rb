class PractitionerDecorator < Draper::Decorator
  delegate_all
  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def full_name_with_suffix
    "#{object.full_name}, #{object.suffix}"
  end
end
