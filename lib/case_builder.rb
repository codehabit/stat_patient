class CaseBuilder
  class << self
    def reply(the_case)
      the_case.save
      message = the_case.messages.order("created_at DESC").first
      message.recipient = the_case.originator == message.sender ? the_case.recipient : the_case.originator
      message.patient = the_case.patient
      message.save
      PractitionerMailer.notification_email(message).deliver
    end

    def originate(the_case)
      the_case.save
      message = the_case.messages.first
      message.update(
        recipient: the_case.recipient,
        sender: the_case.originator,
        patient: the_case.patient
      )
      PractitionerMailer.notification_email(message).deliver
    end
  end
end

