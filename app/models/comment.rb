class Comment < ActiveRecord::Base
  attr_accessible :body, :link_id, :parent_comment_id, :title, :user_id

  belongs_to :link

  belongs_to :user

  belongs_to :parent_comment,
    class_name: "Comment",
    foreign_key: :parent_comment_id

  # Although this association exists, it is not the method used by the app
  # to show child comments
  has_many :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id
end
