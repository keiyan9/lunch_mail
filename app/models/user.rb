class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me


  def self.send_notifications
    self.select_target_users.each do |user|
      response = ApiAccess.api_get({:p1 => "4410"})
      probability = Weather.extract_probability(response).to_i
      if Weather.notice?(probability)
        Notifier.deliver_notice_email(user, probability)
        logger.info "[Mail] send email to #{user.email}"
      end
    end
  end

  def self.select_target_users
    # TODO : 通知対象ユーザを返すようにすること
    self.all
  end

end
