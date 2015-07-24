class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :upvote, :downvote]

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.create(comment_params.merge(user_id: current_user.id))
    respond_with post, comment
  end

  def upvote
    comment = Comment.find(params[:id])
    vote = comment.find_or_initialize_by(:user_id: current_user.id)
    vote.value = 1

    respond_to do |format|
      format.json {
        if vote.save
          render json: { upvotes: comment.upvotes }
        else
          render json: { message: vote.errors.full_messages }
        end
      }
    end
  end

  def downvote
    comment = Comment.find(params[:id])
    vote = comment.find_or_initialize_by(:user_id: current_user.id)
    vote.value = -1

    respond_to do |format|
      format.json {
        if vote.save
          render json: { upvotes: comment.upvotes }
        else
          render json: { message: vote.errors.full_messages }
        end
      }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
