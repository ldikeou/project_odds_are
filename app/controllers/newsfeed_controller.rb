class NewsfeedController < ActionController::Base  

	def index
	# need to get all the activities I need to display
	# activites are completed bids
	# just create a news feed index html.erb and iterate over 
	# the things and display them -micah
	@bid = Bid.find(params[:id])

	end


end
