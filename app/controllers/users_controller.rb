class UsersController < ApplicationController
  before_action :set_user, only: [:likes]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
    @like_posts = @user.like_posts
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def likes
    # ブックマークした投稿一覧を「ブックマークした順」に並び替える
    @like_posts = @user.like_posts.order('created_at desc').page(params[:page])

    # ユーザーがブックマークした投稿を探し、@like_postsに格納
    @tag_list = @like_posts.flat_map { |post| post.tags }.uniq
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
