class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  def as_json(options= {})
    super(options.merge(
      :only => [:id, :title, :link, :upvotes],
      :include => {
        :comments => {
          :include => {
            :user => {
              :only => [:id, :username, :email]
            }
          },
          :only => [:id, :body, :upvotes]
        },
        :user => {
          :only => [:id, :username, :email]
        }
      }
    ))
  end
end
