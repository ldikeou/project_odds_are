class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :sender_id
      t.integer :reciever_id
      t.string :completion_status, :default => "ready_for_range"
      t.string :description
      t.integer :range
      t.integer :recip_guess
      t.integer :challenger_guess

      t.timestamps
    end
  end
end
