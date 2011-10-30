class User < ActiveRecord::Base
  has_one :setting
  has_many :notice_points

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me


  def self.send_notifications
    self.select_target_users.each do |user|
      response_geo = ApiAccess.geo_api_get({:q => user.setting.area})
      categories = [100, 200, 300, 400]
      response_category = "CTG#{categories[rand(categories.length)]}"
      response_gnavi = ApiAccess.gnavi_api_get({:keyid => "dd0f3c4c27d1f6b371cd99acbebe97fb", :latitude => response_geo.result.coordinate.lat, :longitude => response_geo.result.coordinate.lng, :range => 1, :hit_per_page => 999, :category_l => response_category})
      Notifier.notice_email(user,response_gnavi)
      Notifier.deliver_notice_email(user,response_gnavi)
      logger.info "[Mail] send email to #{user.email}"
    end
  end

  def self.select_target_users
    current_time = Time.local(2011,1,1,Time.now.hour,Time.now.min)
    self.select{|user| user.setting.notice_at >= current_time-5.second && user.setting.notice_at < current_time+5.second}
  end

end
