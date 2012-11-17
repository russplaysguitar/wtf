class Tagging < ActiveRecord::Base
  attr_accessible :name
  belongs_to :question
  belongs_to :tag
end
