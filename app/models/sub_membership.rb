class SubMembership < ActiveRecord::Base
  attr_accessible :sub_id, :user_id

  belongs_to :sub

  belongs_to :user
end
