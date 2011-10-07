class Notifier < ActionMailer::Base
  default :from => "any_from_address@example.com"

  def notice_email(user, probability = 0)
    subject = "New Notification for you."
    body = if probability > 60
             "本日の傘指数は#{probability}です！高確率で雨が降るので傘を持参しましょう！"
           else
             "本日の傘指数は#{probability}です。念のために傘を持って出かけましょう。"
           end
    mail(:to => user.email, :subject => subject, :body => body)
  end

end
