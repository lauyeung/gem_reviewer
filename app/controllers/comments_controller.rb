class CommentsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @ruby_gem = RubyGem.find(@review.ruby_gem_id)
    @comment = @review.comments.build(comment_params)
    @comment.user = current_user
    @comment.review = @review

    if @comment.save
      redirect_to ruby_gem_path([@ruby_gem]), notice: 'Comment saved!'
    else
      @vote = Vote.new
      render 'ruby_gems/show'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end
