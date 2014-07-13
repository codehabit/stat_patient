class PractitionerMailer < ActionMailer::Base
  default from: "info@statpatient.com"

  def notification_email(message)
    @practitioner = message.recipient
    @case = message.case
    @message = message
    mail(to: @practitioner.user.email, subject: "Message from StatPatient: #{@case.subject}")
  end
end

