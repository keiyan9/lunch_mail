# -*- coding: utf-8 -*-
class Notifier < ActionMailer::Base
  default :from => "ランチメール <support@lunchmail.jp>"

  def notice_email(user,shop,members)
    subject = "本日のオススメ店＆ランチメンバー"
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
