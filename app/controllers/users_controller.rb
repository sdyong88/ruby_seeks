class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

	def new
	end

	def show
		@user = User.find(params[:id])
		@secrets = @user.secrets
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to "/users/#{@user.id}"
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to :back
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "User Successfully updated"
			redirect_to @user
		else
			flash[:errors] = @user.errors.full_messages
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		session[:user_id] = nil
		redirect_to "/sessions/new"
	end

	private
	def user_params
		params.require(:user).permit(:name,:email,:password,:password_confirmation)
	end
end
