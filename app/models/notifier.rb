class Notifier < ActionMailer::Base
  default :from => "any_from_address@example.com"

  def notice_email(user, message)
    mail( :to => user.email, :subject => message )
  end
end
