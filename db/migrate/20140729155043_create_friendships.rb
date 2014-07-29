class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :friend_requester
      t.integer :friend_accepter
      t.boolean :friends?

      t.timestamps
    end
  end
end
