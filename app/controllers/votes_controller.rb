class VotesController < ApplicationController
  before_action :load_voteable
  
  def create
    @vote = @voteable.votes.new(vote_params)
    @vote.user = current_user
    if @vote.save 
      flash[:notice]= "Thank you for voting!"
      redirect_to ruby_gem_path(@voteable.ruby_gem)
    else
      flash[:notice]= "Vote was not successfully saved. Please keep in mind you can only vote once."
      redirect_to ruby_gem_path(@voteable.ruby_gem)
    end
  end

  protected
  def load_voteable
      #add Comment after 'Review'
      klass = [Review].detect { |c| params["#{c.name.underscore}_id"] }
      @voteable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def vote_params
    params.require(:vote).permit(:score)
  end
end
