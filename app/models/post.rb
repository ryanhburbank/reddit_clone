class Post < ActiveRecord::Base
  has_many :comments

  def as_json(options= {})
    super(options.merge(
      :only => [:id, :title, :link, :upvotes],
      :include => {
        :comments => {
          :only => [:id, :body, :upvotes]
        }
      }
    ))
  end
end
