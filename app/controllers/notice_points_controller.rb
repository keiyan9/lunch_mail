# -*- coding: utf-8 -*-
class NoticePointsController < ApplicationController

  def index
    @setting = current_user.setting
  end

  def new
    @setting = current_user.setting
    @notice_point = NoticePoint.new
  end

  def create
    @setting = current_user.setting
    @notice_point = NoticePoint.new(params[:notice_point])
    @notice_point.user_id = current_user.id
    @notice_point.save
    redirect_to setting_notice_points_path(@setting), :notice => '通知先が追加されました。'
  end

  def destroy
    @setting = current_user.setting
    @notice_point = current_user.notice_points.find(params[:id])
    @notice_point.destroy

    respond_to do |format|
      format.html { redirect_to setting_notice_points_path(@setting)}
    end
  end
end
