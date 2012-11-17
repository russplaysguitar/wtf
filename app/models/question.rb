class Question < ActiveRecord::Base
	belongs_to :user
	has_many :answers
	has_many :comments
	has_many :tags, :through => :taggings
  attr_accessible :description, :title
end
