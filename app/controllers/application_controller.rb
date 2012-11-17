class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_current_user

  private

  def load_current_user
		@current_user = User.find_by_id(session[:user_id])
  end
end
