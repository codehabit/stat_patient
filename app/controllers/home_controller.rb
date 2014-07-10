class HomeController < ApplicationController
  def index
    @practitioner = current_user.practitioner
    @received_cases= @practitioner.received_cases
  end

  def coming_soon
  end
end

