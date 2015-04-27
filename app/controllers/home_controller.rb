class HomeController < ApplicationController
  def self.live_state
    @@state ||= {
      latest: []
    }
  end

  def index
    involved_cases = @current_practitioner.involved_cases
    involved_with_activity = involved_cases.select {|c| c.messages.where(recipient_id: @current_practitioner.id).present? && !c.archived?}
    @inbox_cases = involved_with_activity
    @inbox_cases = @inbox_cases.sort {|a,b| b.updated_at <=> a.updated_at}
    LiveState.register_latest(@current_practitioner.id, unread_for_inbox)
    @sent_cases = current_user.practitioner.originations.order("urgent ASC, last_activity_date DESC")
    @archived_cases = @current_practitioner.originations.where(archived: true) + @current_practitioner.received_cases.where(archived: true)
  end

  def live
    unread_cases = unread_for_inbox
    if (diff = LiveState.diff(@current_practitioner.id, unread_cases)).present?
      data = {ids: diff.map(&:id)}
      LiveState.register_latest @current_practitioner.id, unread_cases
    else
      data = {ids: []}
    end
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

  def unread_for_inbox
    cases = @current_practitioner.involved_cases
    cases.select {|c| c.unread?(@current_practitioner) && !c.archived}
  end
end

