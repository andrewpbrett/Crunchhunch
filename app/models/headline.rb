class Headline < ActiveRecord::Base
  belongs_to :author
  has_many :guesses
  validates_uniqueness_of :text
  
  def self.random
    offset = rand(self.count)
    self.first(:offset => offset)
  end  
  
  def self.weighted
    # this is wildly inefficient
    headlines = self.all
    headlines = headlines.sort_by { |h| h.correct_guesses }
    offset = rand(headlines.size) + headlines.size/2
    if offset > headlines.size
      offset = headlines.size - rand(headlines.size/10) - 1
    end
    headlines[offset]
  end
  
  def correct_guesses
    guesses.reject { |guess| !guess.correct? }.size
  end
end