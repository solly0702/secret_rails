require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  before do
    @user = create_user
  end

  describe "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access secrets/index" do
      get :index
      expect(response).to redirect_to("/sessions/new")
    end
  end

  describe "when signed in as the wrong user" do
    before do
      @wrong_user = create_user "solly", "solly@gamil.com"
      session[:user_id] = @wrong_user.id
    end
    it "cannot access user/show page another user" do
      get :show, id: @user
      expect(response).to redirect_to("/users/#{@wrong_user.id}")
    end
  end

  # describe "GET #create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
