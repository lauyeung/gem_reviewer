require 'rubygems'
require 'gems'

class RubyGemsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]

  def new
    @ruby_gem = RubyGem.new
  end

  def create
    @ruby_gem = RubyGem.new(ruby_gem_params)
    #evaluates if the gem is already listed and returns an error if the
    #input is empty
    if ruby_gem_exists?
      if @ruby_gem.save
        redirect_to ruby_gems_path, notice: 'Gem successfully saved!'
      else
        render :new
      end
    else
      redirect_to new_ruby_gem_path, notice: %Q[I'm sorry, but your
      ruby gem could not be found. Please keep in mind that Ruby Gems
      names do not include empty spaces. You can also use the following link
      to verify your gem's naming format:
      <a href="http://rubygems.org/gems">List of Ruby Gems</a>].html_safe
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

  def format_gem_name(params)
    @name = params[:ruby_gem][:name]
    @gemname = @name.downcase.split.join("")
  end

  def ruby_gem_API_query
    format_gem_name(params)
    Gems.info "#{@gemname}"
  end

  def ruby_gem_exists?
    ruby_gem_API_query != "This rubygem could not be found."
  end
end
