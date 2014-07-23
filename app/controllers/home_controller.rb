class HomeController < ApplicationController
  def index
    @patient_cases = current_user.practitioner.involved_cases.order("updated_at DESC")
  end

  def coming_soon
  end
end

