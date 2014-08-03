class BidsController < ApplicationController

 before_action :authenticate_user!
	
	def index
		@bids = Bid.all
		@new_bid = Bid.new

	end

	def new
		@new_bid = Bid.new
		if params[:q]
			@users = User.search(params[:q]) 
			# binding.pry
		end
	end

	def destroy
		@bid = Bid.find(params[:id])
		@bid.destroy
		redirect_to bids_path
	end


	def edit
		@bid = Bid.find(params[:id])
	end

	def show
		@bid = Bid.find(params[:id])
	end

	def update
		# when recip add the range
		# when recip accepts
		# when recip picks number ie recip_guess
		# when challenger pick number
		# set sender_id
		@bid = Bid.find(params[:id])
		@bid.update(update_params)
		redirect_to @bid 


		# updatebid(action, bid)
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

	def update_receiver
		@bid= bid_params
		@bid.receiver_id = :receiver_id
	end

private
	
	def bid_params
		params.require(:bid).permit(:description , :receiver_id)
		# {description: "my desc", receiver_id: 55}
	end

	def update_params
		if params[:completion_status]
			params.require(:completion_status) # => "string"
		else
			params.require(:otherstuff)
		end
	end



end