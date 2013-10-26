require 'rubygems'
require 'gems'

class RubyGemsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]

  def new
    @ruby_gem = RubyGem.new
  end

   def create
    #BUG - uniqueness is validating "Devise" and "devise"
    #as two unique gems
    @ruby_gem = RubyGem.new(ruby_gem_params)
    if @ruby_gem.save
      if ruby_gem_API_query(params) != "This rubygem could not be found."
        redirect_to new_ruby_gem_path, notice: 'Gem successfully saved!'
      else
        redirect_to new_ruby_gem_path, notice: %Q[This ruby gem could not be found. 
        Please use the following link to check your spelling:
        <a href="http://rubygems.org/gems">List of Ruby Gems</a>].html_safe
      end
    else
      render :new
    end
  end

  def show
    @ruby_gem = RubyGem.find(params[:id])
    @reviews = @ruby_gem.review_sort
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

  def ruby_gem_API_query(params)
    #BUG - Can't handle spaces
    @gemname = params[:ruby_gem][:name]
    Gems.info "#{@gemname}"
  end
end
