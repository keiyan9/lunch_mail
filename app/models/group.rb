# -*- coding: utf-8 -*-
class Group < ActiveRecord::Base
  has_many :users
  has_one :setting
  accepts_nested_attributes_for :setting

  WDAYS = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"].freeze

  def self.send_notifications
    self.select_target_groups.each do |group|
      response_geo = ApiAccess.geo_api_get({:q => group.setting.area})
      until response_geo.result.error != "003"
        response_geo = ApiAccess.geo_api_get({:q => group.setting.area})
      end
      if response_geo.result.error == "001"
        np_users = group.active_users
        np_users.each do |user|
          Notifier.error_email(user, response_geo.result.error)
          Notifier.deliver_error_email(user, response_geo.result.error)
          logger.info "[Mail] send email to #{user.email}"
        end
      else
        response_rests = ApiAccess.get_response_by_group(group, response_geo.result.coordinate)

        day = Time.now
        response_rests.delete_if{ |rest| rest.holiday == WDAYS[day.wday] }

        response_rests.delete_if{ |rest| rest.opentime == nil }
        rests = response_rests.select{ |rest| rest.opentime.include?("11:00") || rest.opentime.include?("11:25") || rest.opentime.include?("11:30") || rest.opentime.include?("12:00")}

        if rests.empty?
          shop = "empty"
          np_users = group.active_users
          np_users.each do |user|
            Notifier.notice_email(user,shop)
            Notifier.deliver_notice_email(user,shop)
            logger.info "[Mail] send email to #{user.email}"
          end
        else
          np_user_groups = group.divide_groups
          np_user_groups.each do |np_user_group|
            shop = rests.instance_of?(Array) ? rests[rand(rests.size)] : rests
            members = np_user_group.map{ |member| member.name }.join(",")
            np_user_group.each do |user|
              Notifier.notice_email(user,shop,members)
              Notifier.deliver_notice_email(user,shop,members)
              logger.info "[Mail] send email to #{user.email}"
            end
          end
        end
      end
    end
  end

  def self.select_target_groups
    self.select{|group| group.target_time? }
  end

  def target_time?
    current_time = Time.local(2011,1,1,Time.now.hour,Time.now.min,Time.now.sec)
    self.setting.notice_at >= current_time-7.second && self.setting.notice_at < current_time+8.second ? true : false
  end

  def active_users
    self.users.select{|user| user.active == true }
  end

  def divide_groups
    notice_users = self.active_users.sort_by{ rand }
    notice_users_count = notice_users.size
    groups = []

    if notice_users_count <= 5
      groups << notice_users
    elsif notice_users_count == 8
      notice_users.each_slice(4){ |four_users_group| groups << four_users_group }
    else
      cut_point = (( notice_users_count / 4 - 3 ) + notice_users_count % 4) * 4
      last_point = notice_users_count - 1
      three_groups = notice_users.slice!(cut_point..last_point)
      notice_users.each_slice(4){ |four_users_group| groups << four_users_group }
      three_groups.each_slice(3){ |three_users_group| groups << three_users_group }
      groups
    end
  end
end
