class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :votes, as: :voteable

  def upvotes
    5
  end

  def as_json(options= {})
    super(options.merge(
      :only => [:id, :title, :link],
      :methods => [:upvotes],
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
