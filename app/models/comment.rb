class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	belongs_to :comment
  attr_accessible :description
end
