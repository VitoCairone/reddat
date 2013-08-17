class Link < ActiveRecord::Base
  attr_accessible :downvotes, :text, :title, :upvotes,
                  :url, :user_id, :sub_ids

  has_many :sub_links, dependent: :destroy

  has_many :user_votes, dependent: :destroy

  has_many :subs, through: :sub_links

  has_many :readers, through: :subs, source: :members

  has_many :comments

  def vote_of(user)
    return false if user.nil?
    self.user_votes.find_by_user_id(user.id)
  end

  def comments_by_parent
    comments_hash = Hash.new([])
    self.comments.each do |comment|
      comments_hash[comment.parent_comment_id] += [comment]
    end
    comments_hash
  end

  # Representing upvotes and downvotes as data memers of the Link is, strictly
  # speaking, slightly undesirable because it is redundant with an association
  # collecting UserVotes objects, but it is much faster since we
  # need never generate SQL queries to check vote values.
  def vote_up
    self.upvotes += 1
    self.save!
  end

  def vote_down
    self.downvotes += 1
    self.save!
  end
end
