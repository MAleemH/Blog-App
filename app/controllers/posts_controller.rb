class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      flash[:success] = 'The post created successfully!'
      redirect_to user_post_url(current_user, @post)
    else
      flash[:error] = 'Opps! Something went wrong, please try again.'
      redirect_to new_user_post_url(current_user)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
