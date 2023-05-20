class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.author_id = current_user.id
    @comment.post_id = @post.id

    if @comment.save
      redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
    else
      render :new, alert: 'Oops! An error has been occurred while creating the comment.'
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @post = @comment.post
    @post.comments_counter -= 1
    @post.save
    @comment.destroy!

    redirect_to user_post_path(id: @post.id), notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
