class PractitionerMailer < ActionMailer::Base
  default from: "noreply@statpatient.com"

  def notification_email(message)
    @practitioner = message.recipient
    @case = message
    mail(to: @practitioner.user.email, subject: "Case from StatPatient: #{@case.subject}")
  end
end

