class PractitionerDecorator < Draper::Decorator
  delegate_all
  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def full_name_with_specialty
    practice_name = object.memberships.present? ? object.memberships.first.name : ""
    specialty = object.specialty.present? ? " (#{object.specialty})" : ""
    "#{object.full_name} - #{practice_name}#{specialty}"
  end

  def full_name_with_suffix
    "#{object.full_name}, #{object.suffix}"
  end
end
