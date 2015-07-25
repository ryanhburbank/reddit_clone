class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many :comments, :as => :commentable, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy

  def upvotes
    votes.sum(:value)
  end

  def comment_count
    comments.count
  end

  def as_json(options= {})
    super(options.merge(
      :only => [:id, :body],
      :methods => [:upvotes, :comment_count],
      :include => {
        :user => {
          :only => [:id, :username, :email]
        },
        :comments => {
          :methods => [:upvotes, :comment_count],
          :include => {
            :user => {
              :only => [:id, :username, :email]
            }
          },
          :only => [:id, :body]
        }
      }
    ))
  end
end
