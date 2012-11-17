class User < ActiveRecord::Base
	has_secure_password
	has_many :questions
	has_many :answers 
	has_many :comments
  attr_accessible :username, :password, :password_confirmation
end
