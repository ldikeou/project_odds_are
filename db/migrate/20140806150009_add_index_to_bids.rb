class AddIndexToBids < ActiveRecord::Migration
  def change
  	add_index :bids, [:sender_id, :receiver_id]
  end
end
