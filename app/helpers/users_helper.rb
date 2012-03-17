# -*- coding: utf-8 -*-
module UsersHelper
  def notice_td_content(user)
    content_tag(:div, :id => "notice-user-#{user.id}") do
      if user.active == true
        link_to "通知中", notice_group_user_path(@group, user, :status => "false"), :remote => true, :class => "btn mini primary"
      else
        link_to "通知する", notice_group_user_path(@group, user, :status => "true"), :remote => true, :class => "btn mini"
      end
    end
  end

  def notice_th_content
    content_tag(:div, :id => "notice-all-user") do
      if @group.users.select{ |user| user.active == false }.any?
        link_to "通知する", group_notice_all_path(@group, :status => "true"), :remote => true, :class => "btn mini"
      else
        link_to "通知中", group_notice_all_path(@group, :status => "false"), :remote => true, :class => "btn mini primary"
      end
    end
  end
end
