class LabOrderSubmitter
  def self.submit(order, request)
    practitioner = order.recipient.members.first
    the_case = Case.new(
      recipient: practitioner,
      originator: order.originator,
      patient: order.patient,
      originator: order.originator
    )
    message = Message.create(body: "New lab order", case: the_case)
    the_case.messages << message
    CaseUpdater.originate(the_case, request)
  end
end

