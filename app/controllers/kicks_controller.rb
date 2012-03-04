class KicksController < ApplicationController
  skip_before_filter :authenticate_user!
  def execute
    logger.info "[Batch] Start at #{Time.now.strftime("%H:%M:%S")} "
    Group.send_notifications
    logger.info "[Batch] Finish at #{Time.now.strftime("%H:%M:%S")} "
    render :text => "OK", :status => "ok"
  end
end
