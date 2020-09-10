class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
       redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
     redirect_to edit_user_path(current_user)
    end
  end

  def show
    @user = User.find(params[:id])
  end
  private
  def user_params
    params.fetch(:user, {}).permit(:nickname, :image, :profile)
  end
end
