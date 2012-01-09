# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  before_filter :load_group

  def index
    @users = current_user.group.users
  end

  def new
    @user = User.new
  end

  def create
    @user = @group.users.build(params[:user])
    if @user.save
      redirect_to group_users_path(@group), :notice => 'メンバーが追加されました。'
    else
      render :action => "new"
    end
  end

  def edit
    @user = @group.users.find(params[:id])
  end

  def update
    @user = @group.users.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to group_users_path(@group), :notice => '登録内容が変更されました。'
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = @group.users.find(params[:id])
    @user.destroy
    redirect_to group_users_path(@group), :notice => 'メンバーから外しました。'
  end

end
