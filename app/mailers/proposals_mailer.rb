class ProposalsMailer < ActionMailer::Base
  default from: Settings.mailers.from

  def created(title, url)
    @title = title
    @url   = url
    mail to: Settings.mailers.notifications.new_paper, subject: "Let's party. New proposal submitted."
  end
end
