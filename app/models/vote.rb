class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true

  belongs_to :user,
    inverse_of: :votes

  validates_presence_of :user
  validates :user_id, :uniqueness => {:scope => [:voteable_id, :voteable_type]}
end
