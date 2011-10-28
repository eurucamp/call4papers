class PapersMailer < ActionMailer::Base
  default from: "drug@drug.org.pl"

  def created(email, url)
    @url = url
    mail to: email, subject: "[wroc_love.rb] Dwarfs have received your proposal."
  end
end
