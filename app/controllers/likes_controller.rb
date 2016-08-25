class LikesController < ApplicationController

	before_action :require_login, only: [:new, :destroy]
	before_action :require_correct_user, only: [:new, :destroy]

	def new
		Like.create(user_id: session[:user_id], secret_id: params[:secret_id])
		redirect_to :back
	end
	
	def destroy
		Like.find_by(secret_id: params[:secret_id]).delete
		redirect_to :back
	end
end
