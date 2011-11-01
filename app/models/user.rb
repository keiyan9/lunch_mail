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

      notice_users = user.notice_points.sort_by{ rand }
      np_count_all = notice_users.size
      np_groups = []
      if np_count_all <= 5
        np_groups = notice_users
      else
        cut_point = (( np_count_all / 4 - 3 ) + np_count_all % 4) * 4
        last_point = np_count_all - 1
        three_groups = notice_users.slice!(cut_point..last_point)
        notice_users.each_slice(4){ |four_users_group| np_groups << four_users_group }
        three_groups.each_slice(3){ |three_users_group| np_groups << three_users_group }
      end

      np_groups.each do |np_group|
        response_category = "CTG#{categories[rand(categories.length)]}"
        response_gnavi = ApiAccess.gnavi_api_get({:keyid => "dd0f3c4c27d1f6b371cd99acbebe97fb", :latitude => response_geo.result.coordinate.lat, :longitude => response_geo.result.coordinate.lng, :range => 1, :hit_per_page => 999, :category_l => response_category})
        if response_gnavi.response.rest.instance_of?(Array)
          shop_count = response_gnavi.response.rest.size
          shop = response_gnavi.response.rest[rand(shop_count)]
        else
          shop = response_gnavi.response.rest
        end
        members = np_group.map{ |member| member.name }.join(",")
        np_group.each do |np|
          Notifier.notice_email(np,shop,members)
          Notifier.deliver_notice_email(np,shop,members)
          logger.info "[Mail] send email to #{np.email}"
        end
      end
    end
  end

  def self.select_target_users
    current_time = Time.local(2011,1,1,Time.now.hour,Time.now.min,Time.now.sec)
    self.select{|user| user.setting.notice_at >= current_time-7.second && user.setting.notice_at < current_time+8.second}
  end

end
