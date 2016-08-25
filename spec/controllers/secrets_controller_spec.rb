require 'rails_helper'

RSpec.describe SecretsController, type: :controller do
	before do
		@user = create_user
		@wrong_user = create_user 'julius', 'julius@lakers.com'
		session[:user_id] = @wrong_user.id
		@secret = @user.secrets.create(content: 'Oops')
	end
	it "cannot acces destroy" do 
		delete :destroy, id: @secret, user_id: @user
		expect(response).to redirect_to("/users/#{@wrong_user.id}")
	end
end
