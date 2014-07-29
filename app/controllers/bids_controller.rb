class BidsController < ApplicationController

 before_action :authenticate_user!
	
	def new
		@new_bid = Bid.new
	end

	def show
	end


end