class Comment < ActiveRecord::Base
  attr_accessible :description
  belongs_to :user
  belongs_to :question
  belongs_to :answer
  has_many :votes
end
