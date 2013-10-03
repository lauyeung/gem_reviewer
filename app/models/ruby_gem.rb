class RubyGem < ActiveRecord::Base
  #ask about where the dependent destory goes so if a
  #gem is removed, the reviews are destroyed
  has_many :reviews,
    inverse_of: :ruby_gem,
    dependent: :nullify

  validates_presence_of :name
  validates_uniqueness_of :name, message: 'already exists'

end
