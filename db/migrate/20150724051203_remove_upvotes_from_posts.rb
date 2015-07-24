class RemoveUpvotesFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :upvotes
  end

  def down
    add_column :posts, :upvotes, :integer
  end
end
