class Notifier < ActionMailer::Base
  default :from => "any_from_address@example.com"

  def self.notice_email(user,shops)
    subject = "New Notification for you."
    number = shops.response.rest.size
    shop = shops.response.rest[rand(number)]
    body =  "本日のオススメ店は#{shop.name}です！ 店舗URL⇒#{shop.url_mobile}"
#    mail(:to => user.email, :subject => subject, :body => body)
  end

end
