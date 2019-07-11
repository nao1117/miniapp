class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @nickname=current_user.nickname
    @posts= user.posts.order("created_at DESC")
  end
end
