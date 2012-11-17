class Vote < ActiveRecord::Base
  attr_accessible :answer_id, :comment_id, :question_id, :user_id
  belongs_to :user
  belongs_to :question
  belongs_to :answer
  belongs_to :comment
end
