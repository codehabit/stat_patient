class HomeController < ApplicationController
  def index
    patient_cases
  end

  def inbox
    patient_cases
    render partial: 'shared/inbox'
  end

  def live
    response.headers["Content-Type"] = "text/event-stream"
    response.stream.write "data: refresh\n\n"
  end

  def coming_soon
  end

  private

  def patient_cases
    @patient_cases = current_user.practitioner.involved_cases.order("urgent ASC, last_activity_date DESC")
  end
end

