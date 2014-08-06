class BidsController < ApplicationController
 before_action :authenticate_user!
	
	def index
		# bids that either I have sent (my_bids) or others have sent (their_bids)
		@received_bids = current_user.received_bids.order('updated_at DESC').page params[:page] # current_user.challenged_bids		
		@sent_bids = current_user.sent_bids.order('updated_at DESC').page params[:page]
		@number_of_bids = @received_bids.size + @sent_bids.size
	end

	def new
		@bid = Bid.new(receiver_id: params[:receiver_id])
		if params[:q]
			@users = current_user.search(params[:q])
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
		# binding.pry

		@bid = Bid.find(params[:id])
		@bid.update(update_params)
		if @bid.completion_status == "determined_winner" || @bid.completion_status == "lost"
			@bid.bid_notifications.create(status: "unread", message: "#{User.find(@bid.sender_id).first_name} has guessed, see the results")
		elsif @bid.completion_status == "ready_for_challenger"
			@bid.bid_notifications.create(status: "unread", message: "#{User.find(@bid.receiver_id).first_name} has set range and guess you're up")
			
		end
		if(@bid.recip_guess != nil || @bid.challenger_guess != nil)
			if params[:redirect_to]
				redirect_to params[:redirect_to]
			else
				redirect_to bids_path
			end
		else
			redirect_to edit_bid_path
		end

	end

	def create
		@bid = Bid.create(bid_params)
		@bid.sender_id = current_user.id
		@bid.save
		if @bid.completion_status == "ready_for_range"
			@bid.bid_notifications.create(status: "unread", message: "#{User.find(@bid.sender_id).first_name} has sent you a bid")
		end
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
			params.require(:bid).permit(:range, :recip_guess, :challenger_guess, 
				:completion_status, :bid_complete)
		end
	end



end