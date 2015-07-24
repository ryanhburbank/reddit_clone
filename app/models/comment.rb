class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :votes, as: :voteable

  def upvotes
    5
  end

  def as_json(options= {})
    super(options.merge(
      :only => [:id, :body],
      :methods => [:upvotes],
      :include => {
        :user => {
          :only => [:id, :username, :email]
        }
      }
    ))
  end
end
