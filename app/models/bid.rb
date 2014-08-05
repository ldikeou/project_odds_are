class Bid < ActiveRecord::Base
	belongs_to :sender, :class_name => 'User'
	belongs_to :receiver, :class_name => 'User'
	has_many :bid_notifications, as: :notifiable

	validate :receiver_id, :sender_id, presence: true
	
  	has_attached_file :bid_complete, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :bid_complete, :content_type => /\Aimage\/.*\Z/

	def pickRange(range, bid)
		bid.range = range
		bid.save
		bid
	end

	def setRecipGuess(guess, bid)
		bid.recip_guess = guess
		bid.save
		bid
	end


	def setChallengerGuess(guess, bid)
		bid.challenger_guess = guess
		bid.save
		bid
	end

	



end
