class Link < ActiveRecord::Base
  attr_accessible :downvotes, :text, :title, :upvotes,
                  :url, :user_id, :sub_ids

  has_many :sub_links, dependent: :destroy

  has_many :subs, through: :sub_links

  has_many :readers, through: :subs, source: :members

  def vote_up
    self.upvotes += 1
  end

  def vote_down
    self.downvotes += 1
  end
end
