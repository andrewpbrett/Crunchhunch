class GuessesController < ApplicationController
  def new
    @headline = Headline.weighted
    @guess = Guess.new
  end
  
  def create
    # record their id (optional)
    
    @guess = Guess.create(params[:guess])
    
    if @guess.correct?
      redirect_to right_path(:x => @guess.headline.author.id)
    else
      redirect_to wrong_path(:x => @guess.headline.author.id)
    end
  end
  
  def right
    @author = Author.find(params[:x])
  end
  
  def wrong
    @author = Author.find(params[:x])
  end
end
