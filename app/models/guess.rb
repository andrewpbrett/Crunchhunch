class Guess < ActiveRecord::Base
  belongs_to :member
  belongs_to :author
  belongs_to :headline
  
  attr_accessible :headline_id, :author_id
  attr_protected :user_id
  
  def correct?
    headline.author == author
  end
end