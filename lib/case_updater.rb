class CaseUpdater
  class << self
    def add_participant(the_case, request)
      the_case.save
      added_participant = the_case.case_watchers.order("created_at DESC").first.watcher
      body = "#{added_participant.name} was added to the conversation"
      message = InfoMessage.create(body: body, case: the_case, patient: the_case.patient, recipient: the_case.originator, sender: the_case.originator)
    end

    def reply(the_case, request)
      the_case.save
      message = the_case.messages.order("created_at DESC").first
      recipient = the_case.originator == message.sender ? the_case.recipient : the_case.originator
      attachments = Attachment.where(attachable_uuid: message.uuid)
      message.update(
        recipient: recipient,
        patient: the_case.patient,
        attachments: attachments
      )
      message.save
      PractitionerMailer.notification_email(message, request).deliver
    end

    def originate(the_case, request)
      the_case.save
      message = the_case.messages.first
      attachments = Attachment.where(attachable_uuid: message.uuid)
      message.update(
        recipient: the_case.recipient,
        sender: the_case.originator,
        patient: the_case.patient,
        attachments: attachments
      )
      PractitionerMailer.notification_email(message, request).deliver
    end
  end
end

