class Setting < ActiveRecord::Base

  validates_presence_of :area
  validates_presence_of :notice_at

end
