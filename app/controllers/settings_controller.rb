# -*- coding: utf-8 -*-
class SettingsController < ApplicationController
  before_filter :load_group

  # GET /settings/1
  # GET /settings/1.xml
  def show
    if current_user.group.setting
      @setting = current_user.group.setting
    else
      redirect_to new_setting_path
    end
  end

  # GET /settings/new
  # GET /settings/new.xml
  def new
    @setting = Setting.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @setting }
    end
  end

  # GET /settings/1/edit
  def edit
    @setting = current_user.group.setting
  end

  # POST /settings
  # POST /settings.xml
  def create
    @setting = @group.build_setting(params[:setting])
    @setting.notice_at = Time.local(2011,1,1,params[:setting][:"notice_at(4i)"], params[:setting][:"notice_at(5i)"])

    if @setting.save
      redirect_to group_setting_path(@group, @setting), :notice => '登録が完了しました。'
    else
      render :action => "new"
    end
  end

  # PUT /settings/1
  # PUT /settings/1.xml
  def update
    @setting = current_user.group.setting

    if @setting.update_attributes(params[:setting])
      redirect_to group_setting_path(@group, @setting), :notice => '登録情報が更新されました。'
    else
      render :action => "edit"
    end
  end

end
