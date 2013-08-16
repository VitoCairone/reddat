class Link < ActiveRecord::Base
  attr_accessible :downvotes, :text, :title, :upvotes,
                  :url, :user_id, :sub_ids

  has_many :sub_links, dependent: :destroy

  has_many :subs, through: :sub_links

  has_many :readers, through: :subs, source: :members

  has_many :comments

  def comments_by_parent
    puts "self = #{self}"
    puts "self.comments = #{self.comments}"
    comments_hash = Hash.new([])
    self.comments.each do |comment|
      # must use += [], NOT <<
      comments_hash[comment.parent_comment_id] += [comment]
    end
    comments_hash
  end

  def vote_up
    self.upvotes += 1
  end

  def vote_down
    self.downvotes += 1
  end
end
