class HomeController < ApplicationController
  def index
    inbox_cases
    sent_cases
  end

  def live
    inbox_cases
    sent_cases
    cases = inbox_cases + sent_cases
    ids = cases.select {|c| c.unread?(@current_practitioner)}.map(&:id)
    data = {ids: ids}
    response.headers["Content-Type"] = "text/event-stream"
    response.stream.write "data: #{data.to_json}\n\n"
  end

  def table_row
    rcase = Case.find(params[:id])
    read_state = rcase.unread?(@current_practitioner) ? "unread" : "read"
    render partial: "shared/case_row", locals: {rcase: rcase, read_state: read_state}
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

