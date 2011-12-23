class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
    if user_signed_in?
      if current_user.setting
        return redirect_to setting_path(current_user.setting)
      else
        return redirect_to new_setting_path
      end
    else
      return unless user_signed_in?
    end
  end
end
