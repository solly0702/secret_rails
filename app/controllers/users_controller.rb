class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      p "@@ success"
      redirect_to edit_user_path(@user.id)
    else
      p "@@ failure"
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    if @user.destroy
      session[:user_id] = nil
      redirect_to new_session_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end
private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name , :password, :password_confirmation)
  end
end
