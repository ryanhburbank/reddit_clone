class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :upvote, :downvote]

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.create(comment_params.merge(user_id: current_user.id))
    respond_with post, comment
  end

  def upvote
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])
    respond_to do |format|
      format.json {
        if comment.vote.create(:user_id: current_user.id, value: 1)
          render json: { success: "Vote created!" }
        else
          render json: { error: "You have already voted!" }
        end
      }
    end
  end

  def downvote
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])

    respond_to do |format|
      format.json {
        if comment.vote.create(:user_id: current_user.id, value: -1)
          render json: { success: "Vote created!" }
        else
          render json: { error: "You have already voted!" }
        end
      }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
