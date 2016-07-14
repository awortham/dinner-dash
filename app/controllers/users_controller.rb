class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			redirect_path = session[:return_to] || '/'
			redirect_to redirect_path, notice: "You Have Successfully Created A New Account!"
		else
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
	end

	private

	def user_params
		params.require(:user).permit(:full_name, :email_address, :screen_name, :password, :password_confirmation)
	end

end
