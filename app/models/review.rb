class Review < ActiveRecord::Base
  belongs_to :ruby_gem,
    inverse_of: :reviews

  belongs_to :user,
    inverse_of: :reviews

  has_many :votes, as: :voteable
    #inverse relationship not required

    validates_presence_of :title
    validates_presence_of :rating
    validates_presence_of :content
    validates_presence_of :user
    validates_presence_of :ruby_gem

    validates_numericality_of :rating
    validates_inclusion_of :rating, :in => 1..10

    def total_score
      votes.pluck(:score).inject(:+)
    end
end
