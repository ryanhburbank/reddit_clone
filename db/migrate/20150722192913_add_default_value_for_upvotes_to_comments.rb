class AddDefaultValueForUpvotesToComments < ActiveRecord::Migration
  def up
    change_column_default :comments, :upvotes, 0
  end

  def down
    change_column_default :comments, :upvotes, nil
  end
end
