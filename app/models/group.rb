class Group < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  accepts_nested_attributes_for :users
  has_one :setting

  validates_presence_of :name
end
