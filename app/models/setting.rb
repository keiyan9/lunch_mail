class Setting < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :area
  validates_presence_of :notice_at

end
