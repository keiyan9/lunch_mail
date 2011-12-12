# -*- coding: utf-8 -*-
class NoticePoint < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name
  validates :email, :email_format => {:message => 'が正しくありません。'}

  def self.groups_by_user(user)
    notice_users = user.notice_points.sort_by{ rand }
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
