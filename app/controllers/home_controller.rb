class HomeController < ApplicationController
  def index
    @received_cases= current_user.practitioner.received_cases
  end
end

