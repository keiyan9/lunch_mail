# -*- coding: utf-8 -*-
class Notifier < ActionMailer::Base
  default :from => "any_from_address@example.com"

  def notice_email(user,shop,members)
    subject = "New Notification for you."
    body =  "本日のオススメ店は#{shop.name}です！ メンバーは#{members}です！ 店舗URL⇒#{shop.url_mobile}"
    mail(:to => user.email, :subject => subject, :body => body)
  end

end
