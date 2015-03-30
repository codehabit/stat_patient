class HomeController < ApplicationController
  def index
    inbox_cases
    sent_cases
  end

  def live
    response.headers["Content-Type"] = "text/event-stream"
    response.stream.write "data: refresh\n\n"
  end

  def coming_soon
  end

  private

  def inbox_cases
    @inbox_cases = current_user.practitioner.received_cases.order("urgent ASC, last_activity_date DESC")
  end

  def sent_cases
    @sent_cases = current_user.practitioner.originations.order("urgent ASC, last_activity_date DESC")
  end
end

