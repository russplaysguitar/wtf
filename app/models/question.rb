class Question < ActiveRecord::Base
	belongs_to :user
	has_many :answers
	has_many :comments
	has_many :tags, :through => :taggings
	has_many :votes
  attr_accessible :description, :title
end
