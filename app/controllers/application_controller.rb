class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

private
  def load_group
    @group = current_user.group
  end
end
