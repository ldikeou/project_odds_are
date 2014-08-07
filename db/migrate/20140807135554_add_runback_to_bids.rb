class AddRunbackToBids < ActiveRecord::Migration
  def change
  	add_column :bids, :runback_recip_guess, :integer
    add_column :bids, :runback_challenger_guess, :integer
  end
end
