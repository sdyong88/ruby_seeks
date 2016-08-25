class SecretsController < ApplicationController
	before_action :require_login, only: [:new, :create, :destroy]

	def new
		@secrets = Secret.all
	end

	def create
		Secret.create(content: params[:content], user_id: params[:id])
		redirect_to :back
	end

	def destroy
		secret = Secret.find(params[:id])
		secret.destroy if secret.user == current_user
		redirect_to "/users/#{current_user.id}"
	end

	private
	def secret_params
		params.require(:secret).permit(:content)
	end
end
