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
      response_rests = ApiAccess.get_response_by_user(user)

      day = Time.now
      response_rests.delete_if{ |rest| rest.holiday == WDAYS[day.wday] }

      response_rests.delete_if{ |rest| rest.opentime == nil }
      rests = response_rests.select{ |rest| rest.opentime.include?("11:00") || rest.opentime.include?("11:25") || rest.opentime.include?("11:30") || rest.opentime.include?("12:00")}

      if rests.empty?
        shop = "empty"
        np_group = user.notice_points
        np_group.each do |np|
          Notifier.notice_email(np,shop)
          Notifier.deliver_notice_email(np,shop)
          logger.info "[Mail] send email to #{np.email}"
        end
      else
        np_groups = NoticePoint.groups_by_user(user)
        np_groups.each do |np_group|
          shop = rests.instance_of?(Array) ? rests[rand(rests.size)] : rests
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
    self.select{|user| user.target_active? && user.target_time?}
  end

  def target_active?
    self.setting.active
  end

  def target_time?
    current_time = Time.local(2011,1,1,Time.now.hour,Time.now.min,Time.now.sec)
    self.setting.notice_at >= current_time-7.second && self.setting.notice_at < current_time+8.second ? true : false
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
