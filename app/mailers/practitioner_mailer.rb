class PractitionerMailer < ActionMailer::Base
  default from: "noreply@statpatient.com"

  def notification_email(message)
    @practitioner = message.recipient
    @message = message
    mail(to: @practitioner.user.email, subject: "Message from StatPatient: #{@message.subject}")
  end
end

