class UserVote < ActiveRecord::Base
  attr_accessible :is_upvote, :link_id, :user_id
end
