class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :upvote, :downvote]

  def index
    respond_with Post.all
  end

  def create
    respond_with Post.create(post_params.merge(user_id: current_user.id))
  end

  def show
    respond_with Post.find(params[:id])
  end

  def upvote
    post = Post.find(params[:id])

    respond_to do |format|
      format.json {
        vote = post.votes.build(user_id: current_user.id, value: 1)
        if vote.save
          render json: { message: vote.errors.full_messages }
        else
          render json: { message: vote.errors.full_messages }
        end
      }
    end
  end

  def downvote
    post = Post.find(params[:id])

    respond_to do |format|
      format.json {
        vote = post.votes.build(user_id: current_user.id, value: -1)
        if vote.save
          render json: { message: vote.errors.full_messages }
        else
          render json: { message: vote.errors.full_messages }
        end
      }
    end
  end

  private

  def post_params
    params.require(:post).permit(:link, :title)
  end
end
