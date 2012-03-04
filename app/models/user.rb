# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  belongs_to :group

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :active

  validates_presence_of :name

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.find_by_email(data.email)
      user
    else
      User.create!(:email => data.email, :password => Devise.friendly_token[0,20], :encrypted_password => Devise.friendly_token[0,20] )
    end
  end

end
