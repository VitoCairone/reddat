class Sub < ActiveRecord::Base
  attr_accessible :name, :moderator

  has_many :sub_memberships

  has_many :sub_links

  has_many :links, through: :sub_links, source: :link

  has_many :members, through: :sub_memerships, source: :user
end
