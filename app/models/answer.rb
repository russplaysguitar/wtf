class Answer < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	has_many :comments
  attr_accessible :description
end
