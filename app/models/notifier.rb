class Notifier < ActionMailer::Base
  default :from => "any_from_address@example.com"

  def notice_email(user, message)
    subject = "New Notification for you."
    mail( :to => user.email, :subject => subject, :body => message )
  end
end
