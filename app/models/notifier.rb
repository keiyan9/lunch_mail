# -*- coding: utf-8 -*-
class Notifier < ActionMailer::Base
  default :from => "ランチメール <support@lunchmail.jp>"

  def notice_email(user,shop=nil,members=nil)
    if shop == "empty"
      subject = "ご報告"
      body = "本日ランチ営業している店舗は、付近で見つかりませんでした"
    else
      subject = "☆本日のオススメ店＆ランチメンバー☆"
      body =  <<"LUNCHMAIL"
＜本日のオススメ店＞
#{shop.name}

＜ランチメンバー＞
#{members}

＜店舗URL＞
#{shop.url_mobile}
LUNCHMAIL
    end

    mail(:to => user.email, :subject => subject, :body => body)
  end

  def error_email(user, error)
    if error == "001"
      subject = "ご報告"
      body =  "不正な住所が登録されています"
      mail(:to => user.email, :subject => subject, :body => body)
    end
  end

end
