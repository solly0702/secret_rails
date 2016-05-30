class LikesController < ApplicationController
  before_action :require_login
  before_action :require_correct_user, only: [:show]

  def index
    redirect_to sessions_path
  end

  def show
    redirect_to user_path(params[:id])
  end

  def create
    like = Like.create(like_params)
    if like.save
      redirect_to secrets_path
    else
      flash[:errors] = like.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    like = Like.find(params[:id])
    if like.destroy
      redirect_to secrets_path
    else
      flash[:errors] = like.errors.full_messages
      redirect_to secrets_path
    end
  end

  private
  def like_params
    params.require(:secret).permit(:secret_id, :user_id)
  end
end
