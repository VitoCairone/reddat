require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :name, :password, :session_token

  has_many :sub_memberships, dependent: :destroy

  has_many :subs, through: :sub_memberships

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
