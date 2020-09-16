class PostsController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :likes, :search]
  before_action :set_post, only: [:edit, :update, :destroy, :show]
  def index
    @post = if params[:tag]
              Post.tagged_with(params[:tag])
            else
              Post.page(params[:page]).per(30).order('created_at DESC')
            end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      redirect_to '/'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to '/'
    else
      render :show
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
    @like = Like.new
    impressionist(@post, nil, unique: [:session_hash])
  end

  def search
    @post = Post.search(params[:keyword])
  end

  def likes
    @post = Post.all.sort { |a, b| b.liked_users.count <=> a.liked_users.count }
    @posts = Post.all.sort { |a, b| b.impressionist_count <=> a.impressionist_count }
  end

  private

  def post_params
    params.require(:post).permit(:vocab, :definition, :example, :image, :tag_list).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless user_signed_in?
  end
end
