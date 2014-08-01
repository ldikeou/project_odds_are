class BidsController < ApplicationController

 before_action :authenticate_user!
	
	def new
		@new_bid = Bid.new
		if params[:q]
			@users = User.search(params[:q]) 
			# binding.pry
		end
	end

	def show
	end

	def update
		# when recip add the range
		# when recip accepts
		# when recip picks number ie recip_guess
		# when challenger pick number
		# set sender_id
		@bid = Bid.find_by_id(params[:id])
		# set reciever_id
		# --> @new_bid.reciever_id = User.find_by("selected user by search form")

		# @bid.range = "what the user selectes"
		
		# set description
	end

	def create
		@bid = Bid.create(bid_params)
		@bid.sender_id = current_user.id
		@bid.save
		# make notification and send to reciever
		redirect_to current_user
	end

	def update_reciever
		@bid= bid_params
		@bid.reciever_id = :reciever_id
	end

private
	
	def bid_params
		params.require(:bid).permit(:description , :reciever_id)
		# {description: "my desc", receiver_id: 55}
	end



end