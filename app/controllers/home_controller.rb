class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
    return redirect_to setting_path(current_user.setting) if user_signed_in?
  end
end
