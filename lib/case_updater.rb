class CaseUpdater
  class << self
    def on_participant_added(the_case, request, added_id)
      the_case.last_activity_date = Time.new
      the_case.save
      added_participant = Organization.find(added_id)
      body = "#{added_participant.name} was added to the conversation"
      message = InfoMessage.create(body: body, case: the_case, patient: the_case.patient, recipient: the_case.originator, sender: the_case.originator)
      invite = Message.new(case: the_case, patient: the_case.patient, recipient: added_participant)
      Mailer.participant_added_email(invite, request).deliver
    end

    def reply(the_case, request)
      the_case.last_activity_date = Time.new
      the_case.new_reply = true
      the_case.archived = false
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
      Mailer.notification_email(message, request).deliver
    end

    def originate(the_case, request)
      the_case.last_activity_date = Time.new
      the_case.save
      message = the_case.messages.first
      attachments = Attachment.where(attachable_uuid: message.uuid)
      message.update(
        recipient: the_case.recipient,
        sender: the_case.originator,
        patient: the_case.patient,
        attachments: attachments
      )
      Mailer.notification_email(message, request).deliver
    end
  end
end

