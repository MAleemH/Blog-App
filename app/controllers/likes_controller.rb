class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(author_id: current_user.id, post_id: @post.id)

    if @like.save
      redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
    else
      render :new, alert: 'Oops! An error has been occurred while creating the like.'
    end
  end
end
