class FriendshipsController < ApplicationController


	def index
		@friends= current_user.friends
	end


	def edit
		@pending_friendships = Friendship.where(accepter_id: current_user, status: "pending")
	end

	def new
		@new_friendship = Friendship.new
		if params[:q]
			@users = User.search(params[:q]) 
			@users -= [current_user]
		end
		
	end

	def create
		Friendship.request(current_user, friendship_params[:accepter_id])
		redirect_to user_path(current_user)
	end

	def delete
		@friendship = Friendship.find(params[:id])
		redirect_to friendships_path
	end


	def update
		f = Friendship.find(params[:id])
		f.update(status: params[:status])
		redirect_to friendships_path, notice: "friendship was #{params[:status]}"
	end

private

	def friendship_params
		params.require(:friendship).permit(:accepter_id)
		# {description: "my desc", receiver_id: 55}
	end

	def method_name
		
	end

end