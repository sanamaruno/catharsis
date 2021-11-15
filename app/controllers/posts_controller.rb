class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:tag_name].split(',')
    if @post.save
      @post.save_tag(tag_list)
      redirect_to post_path(@post.id)
    else
      redirect_to request.referer
    end
  end

  def index
    @tag_list = Tag.all
    @posts = Post.all.reverse_order
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(',')
    if @post.user == current_user
      render :edit
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(',')
    if @post.update(post_params)
      @post.save_tag(tag_list)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(current_user)
  end

  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.all.reverse_order
  end

  private

  def post_params
    params.require(:post).permit(:place, :title, :body, :user_id)
  end

end
