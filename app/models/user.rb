# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  has_one :setting, :dependent => :destroy
  has_many :notice_points, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me


  WDAYS = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"].freeze

  def self.send_notifications
    self.select_target_users.each do |user|
      response_geo = ApiAccess.geo_api_get({:q => user.setting.area})
      response_gnavi = ApiAccess.gnavi_api_get({:keyid => "dd0f3c4c27d1f6b371cd99acbebe97fb", :latitude => response_geo.result.coordinate.lat, :longitude => response_geo.result.coordinate.lng, :range => 1, :hit_per_page => 999, :input_coordinates_mode => 2})

      day = Time.now
      response_gnavi.response.rest.delete_if{ |rest| rest.holiday == WDAYS[day.wday] }
      response_gnavi.response.rest.delete_if{ |rest| rest.opentime == nil }

      rests = response_gnavi.response.rest.select{ |rest| rest.opentime.include?("11:00") || rest.opentime.include?("11:25") || rest.opentime.include?("11:30") || rest.opentime.include?("12:00")}

      if rests.empty?
        shop = "empty"
        np_group = user.notice_points
        np_group.each do |np|
          Notifier.notice_email(np,shop)
          Notifier.deliver_notice_email(np,shop)
          logger.info "[Mail] send email to #{np.email}"
        end
      else
        notice_users = user.notice_points.sort_by{ rand }
        np_count_all = notice_users.size
        np_groups = []

        if np_count_all <= 5
          np_groups << notice_users
        elsif np_count_all == 8
          notice_users.each_slice(4){ |four_users_group| np_groups << four_users_group }
        else
          cut_point = (( np_count_all / 4 - 3 ) + np_count_all % 4) * 4
          last_point = np_count_all - 1
          three_groups = notice_users.slice!(cut_point..last_point)
          notice_users.each_slice(4){ |four_users_group| np_groups << four_users_group }
          three_groups.each_slice(3){ |three_users_group| np_groups << three_users_group }
        end

        np_groups.each do |np_group|
          if rests.instance_of?(Array)
            shop_count = rests.size
            shop = rests[rand(shop_count)]
          else
            shop = rests
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
  end

  def self.select_target_users
    current_time = Time.local(2011,1,1,Time.now.hour,Time.now.min,Time.now.sec)
    self.select{|user| user.setting.active == true && user.setting.notice_at >= current_time-7.second && user.setting.notice_at < current_time+8.second}
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.find_by_email(data.email)
      user
    else
      User.create!(:email => data.email, :password => Devise.friendly_token[0,20], :encrypted_password => Devise.friendly_token[0,20] )
    end
  end

end
