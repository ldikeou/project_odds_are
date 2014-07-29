class BidsController < ApplicationController

	def search
		@bids=Bid.all
		
	end
end