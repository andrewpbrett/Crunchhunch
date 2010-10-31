class Member < ActiveRecord::Base
  has_many :guesses
end