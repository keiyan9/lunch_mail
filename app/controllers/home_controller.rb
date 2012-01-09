class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :signed_redirect

  def index
  end

  def case
  end

  def feature
  end

private
  def signed_redirect
    if user_signed_in?
      if current_user.group && current_user.group.setting
        redirect_to group_setting_path(current_user.group, current_user.group.setting)
      else
        redirect_to new_group_setting_path
      end
    end
  end

end
