class Answer < ActiveRecord::Base
  attr_accessible :description, :is_right
  belongs_to :user
  belongs_to :question
  has_many :comments
  has_many :votes
end
