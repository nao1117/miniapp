class PostsController < ApplicationController

  before_action :move_to_index, except: :index

  def index
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(6)
  end

  def new
    @posts = Post.new
  end

  def create
    Post.create(post_params)
  end

  def destroy
    post= Post.find(params[:id])
    post.destroy if post.user_id == current_user.id
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params) if post.user_id == current_user.id
  end

  private
  def post_params
    params.require(:post).permit(:title,:text,:image).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
