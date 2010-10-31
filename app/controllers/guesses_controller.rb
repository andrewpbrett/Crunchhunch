class GuessesController < ApplicationController
  def new
    @headline = Headline.random
    @guess = Guess.new
  end
  
  def create
    # record their id (optional)
    
    @guess = Guess.create(params[:guess])
    
    if @guess.correct?
      redirect_to right_path
    else
      redirect_to wrong_path
    end
  end
  
  def right
  end
  
  def wrong
  end
end
