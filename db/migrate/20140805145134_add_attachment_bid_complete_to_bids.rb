class AddAttachmentBidCompleteToBids < ActiveRecord::Migration
  def self.up
    change_table :bids do |t|
      t.attachment :bid_complete
    end
  end

  def self.down
    remove_attachment :bids, :bid_complete
  end
end
