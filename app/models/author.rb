class Author < ActiveRecord::Base
  has_many :headlines
  has_many :guesses
end