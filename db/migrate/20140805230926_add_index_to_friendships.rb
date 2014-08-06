class AddIndexToFriendships < ActiveRecord::Migration
  def change
  	add_index :friendships, [:requester_id, :accepter_id]
  end
end
