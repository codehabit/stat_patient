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
    middle = object.middle_initial.blank? ? "" : " #{object.middle_initial}"
    "#{object.last_name}, #{object.first_name}#{middle}"
  end

  def last_first_with_dob
    "#{last_first_name} - #{object.date_of_birth.strftime("%m/%d/%Y")}"
  end

  def last_first_with_dob_and_descr
    "#{last_first_with_dob} - (#{pt_description})"
  end

  def years_old
    (Date.today - object.date_of_birth).to_i / 365
  end

  def pt_description
    "#{years_old} yo #{object.gender}"
  end

end

