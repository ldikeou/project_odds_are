class FriendshipsController < ApplicationController

	def new
		@new_friendship =Friendship.new
		if params[:q]
			@users = User.search(params[:q]) 
			# binding.pry
		end
		
	end

	def create
		Friendship.request(current_user, :accepter)
		redirect_to user_path
	end


	def update
		Friendship.updateStatus(:status, :requester, :accepter)
		redirect_to user_path
	end

private

def friendship_params
		params.require(:friendship).permit(:accepter_id)
		# {description: "my desc", receiver_id: 55}
	end

end