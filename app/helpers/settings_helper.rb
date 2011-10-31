# -*- coding: utf-8 -*-
module SettingsHelper
  def all_notice_points(user)
    user.notice_points.map {|user| user.email}.join(",")
  end
end
