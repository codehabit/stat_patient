class PatientDecorator < Draper::Decorator
  delegate_all
  def full_name
    middle = object.middle_initial.blank? ? "" : "#{object.middle_initial} "
    "#{object.first_name} #{middle}#{object.last_name}"
  end

  def full_name_with_dob
    "#{full_name} - #{object.date_of_birth.strftime("%m/%d/%Y")}"
  end

  def last_first_name
    middle = object.middle_initial.blank? ? "" : "#{object.middle_initial} "
    "#{object.last_name}, #{object.first_name} #{middle}"
  end

  def last_first_with_dob
    "#{last_first_name} - #{object.date_of_birth.strftime("%m/%d/%Y")}"
  end
end

