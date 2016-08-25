require 'rails_helper'

RSpec.describe LikesController, type: :controller do
	before do
		@user = create_user
		@wrong_user = create_user 'julius', 'julious@lakers.com'
		session[:user_id] = @wrong_user.id
	end
	it "is not the correct user" do
		post :new, id: @user
		expect(response).to redirect_to("/users/#{@wrong_user.id}")
	end
end
