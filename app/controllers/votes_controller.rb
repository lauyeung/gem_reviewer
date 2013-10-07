class VotesController < ApplicationController
  before_action :load_voteable

  def create
    @vote = @voteable.votes.new(vote_params)
    @vote.user = current_user
    if @vote.save
      flash[:notice]= "Thank you for voting!"
      redirect_to ruby_gem_path(@voteable.ruby_gem)
    else
      flash[:notice]= "You have already voted for this review!"
      redirect_to ruby_gem_path(@voteable.ruby_gem)
    end
  end

  # def update
  #   @ruby_gem = RubyGem.find(params[:ruby_gem_id])
  #   @vote = @ruby_gem.votes.build(vote_params)
  #   @vote.user = current_user
  #   @vote.voteable_id = @ruby_gem._id
  #   @vote.voteable_type = @ruby_gem.class

    # if @vote.votable_type.voted_by(current_user)
    #   if @review.update(review_params)
    #     redirect_to ruby_gem_path(@ruby_gem), notice: 'Review successfully updated!'
    #   else
    #     @comment = Comment.new
    #     @vote = Vote.new
    #     render 'ruby_gems/show'
    #   end
    # end
  # end

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
