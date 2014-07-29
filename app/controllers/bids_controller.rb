class BidsController < ApplicationController


 before_action :authenticate_user!
	

	def new
		@bid = Bids.new
	end

	def show
	end


end