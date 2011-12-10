# -*- coding: utf-8 -*-
class NoticePointsController < ApplicationController

  def index
    @setting = current_user.setting
    @notice_points = current_user.notice_points
  end

  def new
    @setting = current_user.setting
    @notice_point = NoticePoint.new
  end

  def edit
    @setting = current_user.setting
    @notice_point = current_user.notice_points.find(params[:id])
  end

  def create
    @setting = current_user.setting
    @notice_point = NoticePoint.new(params[:notice_point])
    @notice_point.user_id = current_user.id

    respond_to do |format|
      if @notice_point.save
        format.html { redirect_to setting_notice_points_path(@setting), :notice => 'メンバーが追加されました。' }
      else
        format.html { render :action => "new"}
      end
    end
  end

  def update
    @setting = current_user.setting
    @notice_point = current_user.notice_points.find(params[:id])

    respond_to do |format|
      if @notice_point.update_attributes(params[:notice_point])
        format.html { redirect_to setting_notice_points_path(@setting), :notice => '登録内容が変更されました。'}
      else
        format.html { render :action => "edit"}
      end
    end
  end

  def destroy
    @setting = current_user.setting
    @notice_point = current_user.notice_points.find(params[:id])
    @notice_point.destroy

    respond_to do |format|
      format.html { redirect_to setting_notice_points_path(@setting), :notice => 'メンバーから外しました。'}
    end
  end
end
