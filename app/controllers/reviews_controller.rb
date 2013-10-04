class ReviewsController < ApplicationController

  def create
    @ruby_gem = RubyGem.find(params[:ruby_gem_id])
    @review = @ruby_gem.reviews.build(review_params)
    @review.user = current_user
    if @ruby_gem.reviews.where(user: current_user).empty?
      if @review.save
        redirect_to ruby_gem_path([@ruby_gem]), notice: 'Review successfully added!'
      else
        render "ruby_gems/show"
      end
    else
      flash[:notice] = "Can't review same gem twice."
      render 'ruby_gems/show'
      # redirect_to ruby_gem_path([@ruby_gem]), notice: "Can't review same gem twice"
    end
  end

  private
  def review_params
    params.require(:review).permit(:title, :content, :rating)
  end
end
