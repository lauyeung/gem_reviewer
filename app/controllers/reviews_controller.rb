class ReviewsController < ApplicationController

  def create
    @ruby_gem = RubyGem.find(params[:ruby_gem_id])
    @review = @ruby_gem.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to ruby_gem_path(@ruby_gem), notice: 'Review successfully saved!'
    else
      @comment = Comment.new
      render template: 'ruby_gems/show'
    end

  end

  private
  def review_params
    params.require(:review).permit(:title, :content, :rating)
  end
end
