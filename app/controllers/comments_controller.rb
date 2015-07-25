class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :upvote, :downvote]

  def create
    comment = (params[:post_id] ? create_post_comment : create_comment_comment)
    respond_with comment
  end

  def show
    respond_with Comment.find(params[:id])
  end

  def upvote
    comment = Comment.find(params[:id])
    vote = comment.find_or_initialize_by(user_id: current_user.id)
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
    vote = comment.find_or_initialize_by(user_id: current_user.id)
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

  def create_post_comment
    post = Post.find(params[:post_id])
    post.comments.create(comment_params.merge(user_id: current_user.id))
  end

  def create_comment_comment
    comment = Comment.find(params[:comment_id])
    comment.comments.create(comment_params.merge(user_id: current_user.id))
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
