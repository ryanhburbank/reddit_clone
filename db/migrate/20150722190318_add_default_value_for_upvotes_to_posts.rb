class AddDefaultValueForUpvotesToPosts < ActiveRecord::Migration
  def up
    change_column_default :posts, :upvotes, 0
  end

  def down
    change_column_default :posts, :upvotes, nil
  end
end
