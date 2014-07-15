class CaseBuilder
  class << self
    def reply(the_case, request)
      the_case.save
      message = the_case.messages.order("created_at DESC").first
      recipient = the_case.originator == message.sender ? the_case.recipient : the_case.originator
      images = Image.where(imageable_uuid: message.uuid)
      message.update(
        recipient: recipient,
        patient: the_case.patient,
        images: images
      )
      message.save
      PractitionerMailer.notification_email(message, request).deliver
    end

    def originate(the_case, request)
      the_case.save
      message = the_case.messages.first
      images = Image.where(imageable_uuid: message.uuid)
      message.update(
        recipient: the_case.recipient,
        sender: the_case.originator,
        patient: the_case.patient,
        images: images
      )
      PractitionerMailer.notification_email(message, request).deliver
    end
  end
end

