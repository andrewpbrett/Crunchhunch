class Headline < ActiveRecord::Base
  belongs_to :author
  has_many :guesses
  validates_uniqueness_of :text
  
  def self.random
    offset = rand(self.count)
    self.first(:offset => offset)
  end  
  
  def self.weighted(weights=nil)
    self.all.weighted_random(:correct_guesses)
  end
  
  def correct_guesses
    guesses.reject { |guess| !guess.correct? }.size
  end
end