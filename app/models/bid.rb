class Bid < ActiveRecord::Base
	belongs_to :sender, :class_name => 'User'
	belongs_to :receiver, :class_name => 'User'
	has_many :bid_notifications, as: :notifiable


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
