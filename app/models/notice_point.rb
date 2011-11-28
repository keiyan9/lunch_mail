# -*- coding: utf-8 -*-
class NoticePoint < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name
  validates :email, :email_format => {:message => 'が正しくありません。'}
end
