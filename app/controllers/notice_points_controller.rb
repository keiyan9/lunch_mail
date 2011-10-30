# -*- coding: utf-8 -*-
class NoticePointsController < ApplicationController

  def new
    @setting = current_user.setting
    @notice_point = NoticePoint.new
  end

  def create
    @setting = current_user.setting
    @notice_point = NoticePoint.new(params[:notice_point])
    @notice_point.user_id = current_user.id
    @notice_point.save
    redirect_to setting_path(@setting), :notice => '通知先が追加されました。'
  end
end
