class RemoveUpvotesFromComments < ActiveRecord::Migration
  def up
    remove_column :comments, :upvotes
  end

  def down
    add_column :comments, :upvotes, :integer
  end
end
