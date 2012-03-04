# -*- coding: utf-8 -*-
class UsersController < ApplicationController

  def index
    @users = @group.users
  end

  def new
    @user = @group.users.build
  end

  def edit
    @user = @group.users.find(params[:id])
  end

  def create
    @user = @group.users.build(params[:user])
    @user.password = ActiveSupport::SecureRandom.base64(8)
    @user.active = true
    if @user.save
      redirect_to group_users_path(@group), :notice => "登録が完了しました。"
    else
      render :action => "new"
    end
  end

  def update
    @user = @group.users.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to group_users_path(@group), :notice => "登録情報を更新しました。"
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = @group.users.find(params[:id])
    @user.destroy
    redirect_to group_users_path(@group), :notice => "登録を解除しました。"
  end

  def notice
    @user = @group.users.find(params[:id])
    @user.active = params[:status]
    @user.save
    respond_to do |format|
      format.js { render "notice"}
    end
  end
end
