class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  def index
    @user = session[:user_id]
    @users = User.all
  end

  def create
    secret = Secret.create(secret_params)
    if secret.save!
      redirect_to user_path(secret.user_id)
    else
      flash[:errors] = secret.errors.full_messages
      redirect_to user_path(secret.user_id)
    end
  end

  def destroy
    secret = Secret.find(params[:id])
    if secret.destroy! && secret.user == current_user
      redirect_to user_path(secret.user_id)
    else
      flash[:errors] = secret.errors.full_messages
      redirect_to user_path(secret.user_id)
    end
  end

  private
  def secret_params
    params.require(:user).require(:secrets).permit(:content, :user_id)
  end
end
