class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def as_json(options= {})
    super(options.merge(
      :only => [:id, :body, :upvotes],
      :include => {
        :user => {
          :only => [:id, :username, :email]
        }
      }
    ))
  end
end
