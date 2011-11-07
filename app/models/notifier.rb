# -*- coding: utf-8 -*-
class Notifier < ActionMailer::Base
  default :from => "lunch@mail.com"

  def notice_email(user,shop,members)
    subject = "New Notification for you."
    body =  <<"LUNCHMAIL"
＜本日のオススメ店＞
#{shop.name}

＜メンバー＞
#{members}

＜店舗URL＞
#{shop.url_mobile}
LUNCHMAIL

    mail(:to => user.email, :subject => subject, :body => body)
  end

end
