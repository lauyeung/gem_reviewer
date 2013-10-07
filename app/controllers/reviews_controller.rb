class ReviewsController < ApplicationController

  def create
    @ruby_gem = RubyGem.find(params[:ruby_gem_id])
    @review = @ruby_gem.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to ruby_gem_path(@ruby_gem), notice: 'Review successfully saved!'
    else
      @comment = Comment.new
      @vote = Vote.new
      @reviews = @ruby_gem.reviews.sort_by { |review| "review.total_score DESC" }.reject{|review|review.id.nil?}
      render 'ruby_gems/show'
    end

  end

  # def edit
  #   @ruby_gem = RubyGem.find(params[:ruby_gem_id])
  #   @review = Review.find(params[:id])
  # end

  def update
    @ruby_gem = RubyGem.find(params[:ruby_gem_id])
    @review = Review.find(params[:id])
    @review.user = current_user
    if @ruby_gem.reviewed_by?(current_user)
      if @review.update(review_params)
        redirect_to ruby_gem_path(@ruby_gem), notice: 'Review successfully updated!'
      else
        @comment = Comment.new
        @vote = Vote.new
        @reviews = @ruby_gem.reviews.sort_by { |review| "review.total_score DESC" }.reject{|review|review.id.nil?}
        render 'ruby_gems/show'
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @ruby_gem = @review.ruby_gem
    if @ruby_gem.reviewed_by?(current_user)
      @review.destroy
      redirect_to ruby_gems_path
    end
  end

  private
  def review_params
    params.require(:review).permit(:title, :content, :rating)
  end
end




