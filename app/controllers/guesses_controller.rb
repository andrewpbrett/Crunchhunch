class GuessesController < ApplicationController
  def new
    @headline = Headline.weighted
    @guess = Guess.new
  end
  
  def create
    @guess = Guess.create(params[:guess])
    
    @member = Member.find_or_create_by_cookie_hash(cookies[:crunchhunch])
    
    @guess.member = @member
    
    @guess.save
    
    if @guess.correct?
      redirect_to right_path(:x => @guess.headline.author.id)
    else
      redirect_to wrong_path(:x => @guess.headline.author.id)
    end
  end
  
  def right
    @author = Author.find(params[:x])
    @member = Member.find_by_cookie_hash(cookies[:crunchhunch])
  end
  
  def wrong
    @author = Author.find(params[:x])
    @member = Member.find_by_cookie_hash(cookies[:crunchhunch])    
  end
end
