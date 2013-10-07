class RubyGemsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]

  def new
    @ruby_gem = RubyGem.new
  end

  def create
    @ruby_gem = RubyGem.new(ruby_gem_params)

    if @ruby_gem.save
      redirect_to new_ruby_gem_path, notice: 'Gem successfully saved!'
    else
      render :new
    end
  end

  def show
    @ruby_gem = RubyGem.find(params[:id])
    binding.pry
    @review = Review.new
    @vote = Vote.new
    @comment = Comment.new
  end

  def index
    @q = RubyGem.search(params[:q])
    @ruby_gems = @q.result(distinct: true)
  end

  protected

  def ruby_gem_params
    params.require(:ruby_gem).permit(:name)
  end

end
