require 'rails_helper'

RSpec.describe SecretsController, type: :controller do

  # describe "GET #index" do
  #   it "returns http success" do
  #     get :index
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "when logged in as the wrong user" do
    before do
      @wrong_user = create_user "julius", "julius@lakers.com"
      session[:user_id] = @wrong_user.id
      @secret = @wrong_user.secrets.create(content: "Ooops")
    end
    it "cannot access destroy" do
      delete :destroy, id: @secret, user_id: @user
      expect(response).to redirect_to("/users/#{@wrong_user.id}")
    end
  end

end
