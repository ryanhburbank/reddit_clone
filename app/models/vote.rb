class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user
  validates_uniqueness_of :voteable_id, scope: :user_id
end
