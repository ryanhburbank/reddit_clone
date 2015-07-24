class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy

  def upvotes
    votes.sum(:value)
  end

  def comment_count
    comments.count
  end

  def as_json(options= {})
    super(options.merge(
      :only => [:id, :title, :link],
      :methods => [:upvotes, :comment_count],
      :include => {
        :comments => {
          :methods => [:upvotes],
          :include => {
            :user => {
              :only => [:id, :username, :email]
            }
          },
          :only => [:id, :body]
        },
        :user => {
          :only => [:id, :username, :email]
        }
      }
    ))
  end
end
