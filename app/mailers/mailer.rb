class Mailer < ActionMailer::Base
  default from: "info@statpatient.com"

  def notification_email(message, request)
    @request = request
    @practitioner = message.recipient
    @case = message.case
    @message = message
    email = @practitioner.user.present? ? @practitioner.user.email : @practitioner.email
    mail(to: email, subject: "Message from StatPatient: #{@case.subject}")
  end

  def participant_added_email(message, request)
    @request = request
    @recipient = message.recipient
    @case = message.case
    @message = message
    mail(to: @recipient.email, subject: "Message from StatPatient: #{@case.subject}")
  end
end

