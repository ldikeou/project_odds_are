class FriendshipsController < ApplicationController


	def edit
		@pending_friendships = Friendship.where(accepter_id: current_user, status: "pending")
	end

	def new
		@new_friendship = Friendship.new
		if params[:q]
			@users = User.search(params[:q]) 
			# binding.pry
		end
		
	end

	def create
		# binding.pry
		Friendship.request(current_user, friendship_params[:accepter_id])
	
		redirect_to user_path(current_user)

	end


	def update
		f = Friendship.find(params[:id])
		f.update(status: params[:status])
		redirect_to friendships_path, notice: "friendshipwas #{params[:status]}"
	end

private

	def friendship_params
		params.require(:friendship).permit(:accepter_id)
		# {description: "my desc", receiver_id: 55}
	end

	def method_name
		
	end

end