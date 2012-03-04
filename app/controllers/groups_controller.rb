# -*- coding: utf-8 -*-
class GroupsController < ApplicationController
  skip_before_filter :load_group, :only => ["new", "create"]

  def new
    @group = Group.new
    @setting = @group.build_setting
  end

  def show
    redirect_to new_group_path unless @group
  end

  def edit
    @setting = @group.setting
  end

  def create
    params[:group][:setting_attributes]["notice_at(1i)"] = "2011"
    params[:group][:setting_attributes]["notice_at(2i)"] = "1"
    params[:group][:setting_attributes]["notice_at(3i)"] = "1"
    @group = Group.new(params[:group])
    if @group.save
      current_user.group = @group
      current_user.save
      redirect_to group_path(@group), :notice => "登録が完了しました。"
    else
      render :action => "new"
    end
  end

  def update
    if @group.update_attributes(params[:group])
      redirect_to group_path(@group), :notice => "登録情報を更新しました。"
    else
      render :action => "edit"
    end
  end
end
