class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:tag_name].split(nil)
    if @post.save
      @post.save_tag(tag_list)
      redirect_to post_path(@post.id)
    else
      redirect_to request.referer
    end
  end

  def index
    @tag_list = Tag.all
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def search
  end

  private

  def post_params
    params.require(:post).permit(:place, :title, :body, :user_id)
  end

end
