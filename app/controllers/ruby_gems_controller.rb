class RubyGemsController < ApplicationController

  def new
    @ruby_gem = RubyGem.new
  end

  def create
    @ruby_gem = RubyGem.new(ruby_gem_params)

    if @ruby_gem.save
      redirect_to new_ruby_gem_path, notice: 'Gem successfully added!'
    else
      render :new
    end
  end

  def index
    @ruby_gems = RubyGem.order('name')
  end


  protected

  def ruby_gem_params
    params.require(:ruby_gem).permit(:name)
  end

end
