class PatientDecorator < Draper::Decorator
  delegate_all
  def full_name
    middle = object.middle_initial.blank? ? "" : "#{object.middle_initial} "
    "#{object.first_name} #{middle}#{object.last_name}"
  end
end

