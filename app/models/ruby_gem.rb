class RubyGem < ActiveRecord::Base
  #ask about where the dependent destory goes so if a
  #gem is removed, the reviews are destroyed
  has_many :reviews,
    inverse_of: :ruby_gem,
    dependent: :nullify

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false, message: 'already exists'
  #evaluates 'devise' and 'Devise' as the same

  def reviewed_by?(user)
    reviews.pluck(:user_id).include?(user.id)
  end

  def review_sort
    reviews.sort_by{ |review| "review.total_score DESC" }.reject{|review|review.id.nil?}
  end
end
