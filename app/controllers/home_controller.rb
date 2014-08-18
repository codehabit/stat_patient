class HomeController < ApplicationController
  def index
    @patient_cases = current_user.practitioner.involved_cases.order("urgent ASC, last_activity_date DESC")
  end

  def coming_soon
  end
end

