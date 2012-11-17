class Question < ActiveRecord::Base
  attr_accessible :description, :title
  belongs_to :user
  has_many :answers
  has_many :comments
  has_many :tags, :through => :taggings
  has_many :votes
end
