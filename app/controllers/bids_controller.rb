class BidsController < ApplicationController

 before_action :authenticate_user!
	
	def index
		# bids that either I have sent (my_bids) or others have sent (their_bids)
		@received_bids = current_user.received_bids.order('updated_at DESC') # current_user.challenged_bids		
		@sent_bids = current_user.sent_bids.order('updated_at DESC')
	end

	def new
		@bid = Bid.new(receiver_id: params[:receiver_id])
		if params[:q]
			@users = User.search(params[:q]) 
			@users -= [current_user]
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
		# redirect_to board(range)
	end


	def update
		# when recip add the range
		# when recip accepts
		# when recip picks number ie recip_guess
		# when challenger pick number
		# set sender_id
		@bid = Bid.find(params[:receiver_id])
		@bid.update(update_params)
		if(@bid.recip_guess != nil || @bid.challenger_guess != nil)
			redirect_to user_path(current_user)
		else
			redirect_to edit_bid_path
		end
	end

	def create
		@bid = Bid.create(bid_params)
		@bid.sender_id = current_user.id
		@bid.save
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
			{completion_status: params[:completion_status]}		
		else
			params.require(:bid).permit(:range, :recip_guess, :challenger_guess)
		end
	end



end