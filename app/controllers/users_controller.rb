class UsersController < ApplicationController
  before_action :admin_user,     only: :destroy

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(@user) unless @user == current_user
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

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_back(fallback_location: root_path)
    else
      render :show
    end
  end

  def search
    @users = User.search(params[:keyword])
  end

  def following
    @user = User.find(params[:id])
    @users = @user.follower
    render 'following'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followed
    render 'followed'
  end

  def likes
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:nickname, :image, :profile)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
