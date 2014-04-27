class CommunicationsMailer < ActionMailer::Base
  default from: Settings.mailers.from
  helper ApplicationHelper

  def communication_mail(communication)
    @communication = communication

    recipients = @communication.recipients_emails
    recipients << @communication.sender_email

    mail bcc: recipients.uniq, subject: communication.subject
  end
end
