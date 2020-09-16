class UsersController < ApplicationController
  before_action :admin_user,     only: :destroy
  before_action :set_user, only: [:edit, :update, :destroy, :show, :following, :followers, :likes]
  def index
    @users = User.all.sort {|a,b| b.followed.count <=> a.followed.count}
  end

  def edit
    redirect_to user_path(@user) unless @user == current_user
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def show
    impressionist(@user, nil, unique: [:session_hash])
  end

  def destroy
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
    @users = @user.follower
    render 'following'
  end

  def followers
    @users = @user.followed
    render 'followed'
  end

  def likes
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:image, :nickname, :profile)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
