class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_username(params[:session][:username])
		if !user.nil? && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			redirect_to :controller => :users, :action => "show", :id => user.id
		else
			flash[:now] = "Invalid user/pass combo"
			render :new
		end
	end

	def destroy
		session.clear
		redirect_to root_path
	end
end