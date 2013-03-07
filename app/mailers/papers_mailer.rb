class PapersMailer < ActionMailer::Base
  default from: "cfp@eurucamp.org"

  def created(title, url)
    @title = title
    @url   = url
    mail to: CFP_EMAIL, subject: "Let's party. New proposal submitted."
  end
end
