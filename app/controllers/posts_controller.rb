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
    vote = post.votes.find_or_initialize_by(user_id: current_user.id)
    vote.value = 1

    respond_to do |format|
      format.json {
        if vote.save
          render json: { upvotes: post.upvotes }
        else
          render json: { message: vote.errors.full_messages }
        end
      }
    end
  end

  def downvote
    post = Post.find(params[:id])
    vote = post.votes.find_or_initialize_by(user_id: current_user.id)
    vote.value = -1

    respond_to do |format|
      format.json {
        if vote.save
          render json: { upvotes: post.upvotes }
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
