# -*- coding: utf-8 -*-
module UsersHelper
  def notice_td_content(user)
    content_tag(:div, :id => "notice-user-#{user.id}") do
      if user.active == true
        link_to "通知中", notice_group_user_path(@group, user, :status => "false"), :remote => true, :class => "btn small primary"
      else
        link_to "通知する", notice_group_user_path(@group, user, :status => "true"), :remote => true, :class => "btn small"
      end
    end
  end
end
