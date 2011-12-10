# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  before do
    @time_now = Time.local(2011,1,1,12,0,0).in_time_zone("Tokyo")
    Time.stub!(:now).and_return(@time_now)
    @user_1200_1 = FactoryGirl.create(:user_1200_1)
    @user_1200_2 = FactoryGirl.create(:user_1200_2)
    @user_1200_off = FactoryGirl.create(:user_1200_off)
    @user_1230 = FactoryGirl.create(:user_1230)
    @setting_1 = FactoryGirl.create(:setting_1, :user_id => @user_1200_1.id)
    @setting_2 = FactoryGirl.create(:setting_2, :user_id => @user_1200_2.id)
    @setting_3 = FactoryGirl.create(:setting_3, :user_id => @user_1230.id)
    @setting_4 = FactoryGirl.create(:setting_4, :user_id => @user_1200_off.id)
  end
  describe "#self.select_target_users" do
    subject { User.select_target_users }
    it "通知がオン、かつ、現在時刻に設定しているユーザーが全員返ること" do
      should == [@user_1200_1, @user_1200_2]
    end
  end
end
