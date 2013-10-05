class Review < ActiveRecord::Base
  belongs_to :ruby_gem,
    inverse_of: :reviews

  belongs_to :user,
    inverse_of: :reviews

  has_many :comments,
    inverse_of: :review

  validates_presence_of :title
  validates_presence_of :rating
  validates_presence_of :content
  validates_presence_of :user
  validates_presence_of :ruby_gem

  validates_uniqueness_of :ruby_gem_id, scope: :user_id

  validates_numericality_of :rating
  validates_inclusion_of :rating, :in => 1..10
end
