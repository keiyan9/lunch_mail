class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!, :load_group

  private
  def load_group
    @group = current_user.group if current_user
  end
end
