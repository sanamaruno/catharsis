class LikesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :post_params, only: [:create, :destroy]

  def create
    like = current_user.likes.build(post_id: @post.id)
    like.save
    # app/views/likes/create.js.erb参照
  end

  def destroy
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy
    # app/views/likes/destroy.js.erb参照
  end

  private
  def post_params
    @post = Post.find(params[:post_id])
  end
end
