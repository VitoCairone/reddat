class Sub < ActiveRecord::Base
  attr_accessible :name, :moderator, :links_attributes

  has_many :sub_memberships, dependent: :destroy

  has_many :sub_links, dependent: :destroy

  has_many :links, through: :sub_links, source: :link

  has_many :members, through: :sub_memerships, source: :user

  accepts_nested_attributes_for :links, :reject_if => :all_blank
end
