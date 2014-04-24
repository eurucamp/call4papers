class FeedbacksMailer < ActionMailer::Base
  default from: Settings.mailers.from

  def contact(title, url, recipient, mentor, feedback)
    @title     = title
    @url       = url
    @recipient = recipient
    @mentor    = mentor
    @feedback  = feedback
    mail to: recipient.email, reply_to: mentor.email, subject: "Your proposal received feedback"
  end
end
