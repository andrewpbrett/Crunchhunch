class Headline < ActiveRecord::Base
  belongs_to :author
  has_many :guesses
  
  def self.random
    offset = rand(self.count)
    self.first(:offset => offset)
  end  
end