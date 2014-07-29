class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :requester_id
      t.integer :accepter_id
      t.string :status

      t.timestamps
    end
  end
end
