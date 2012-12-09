class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :username, :password, :password_confirmation
  validates :username, :presence => true,
            :uniqueness => {:case_sensitive => false},
            :format => { :with => /\A\w+\Z/, :message => "is invalid"}
  validates :password, :presence => true,
            :length => { :in => 6..255 }  
  has_many :questions
  has_many :answers 
  has_many :comments
end
