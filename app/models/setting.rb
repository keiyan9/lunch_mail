class Setting < ActiveRecord::Base
  belongs_to :group

  validates_presence_of :area
  validates_presence_of :notice_at

end
