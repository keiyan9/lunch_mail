class User < ActiveRecord::Base
  has_one :setting

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me


  def self.send_notifications
    self.select_target_users.each do |user|
      response = ApiAccess.api_get({:keyid => "dd0f3c4c27d1f6b371cd99acbebe97fb", :address => user.setting.area})
     p Notifier.notice_email(user,response)
#      Notifier.deliver_notice_email(user,response)
#      logger.info "[Mail] send email to #{user.email}"
    end
  end

  def self.select_target_users
    current_time = Time.local(2011,1,1,Time.now.hour,Time.now.min)
    self.select{|user| user.setting.notice_at > current_time-3.minute && user.setting.notice_at < current_time+3.minute}
  end

end
