class ChangeColumn < ActiveRecord::Migration
  def change
  	rename_column :bids, :reciever_id, :receiver_id
  end
end
