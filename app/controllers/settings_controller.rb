# -*- coding: utf-8 -*-
class SettingsController < ApplicationController

  # GET /settings/1
  # GET /settings/1.xml
  def show
    if current_user.setting
      @setting = current_user.setting
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
    @setting = current_user.setting
  end

  # POST /settings
  # POST /settings.xml
  def create
    @setting = Setting.new(params[:setting])
    @setting.user_id = current_user.id
    @setting.notice_at = Time.local(2011,1,1,params[:setting][:"notice_at(4i)"], params[:setting][:"notice_at(5i)"])

    respond_to do |format|
      if @setting.save
        format.html { redirect_to(@setting, :notice => '登録が完了しました。') }
        format.xml  { render :xml => @setting, :status => :created, :location => @setting }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /settings/1
  # PUT /settings/1.xml
  def update
    @setting = current_user.setting

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        format.html { redirect_to(@setting, :notice => '登録情報が更新されました。') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end

end
