class Comment < ActiveRecord::Base
  belongs_to :review,
    inverse_of: :comments

  belongs_to :user,
    inverse_of: :comments

  validates_presence_of :comment_content
  validates_presence_of :user
  validates_presence_of :review
end
