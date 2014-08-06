class FriendshipsController < ApplicationController
	before_action :authenticate_user!

	def index

		@friends = User.find(params[:id]).friends
		@friend_id=params[:id]

	end


	def edit
		@pending_friendships = Friendship.where(accepter_id: current_user, status: "pending")
	end

	def new

		@friendship = Friendship.new
		if params[:q]
			@users = User.search(params[:q]) 
			@users -= [current_user]
		end
		
	end

	def create
		Friendship.request(current_user.id, params[:accepter_id].to_i)
		redirect_to user_path(current_user)
	end

	def delete
		@friendship = Friendship.find(params[:id])
		redirect_to friendships_path
	end


	def update
		f = Friendship.find(params[:id])
		f.update(status: params[:status])

		if f.status == "accepted" 
			f.friendship_notifications.create(status: "unread", message: "#{f.accepter_id.first_name} has accepted your friend request")
		end

		redirect_to friendships_path(params: {id: params[:id]}), notice: "friendship was #{params[:status]}"

	end

private

	def friendship_params
		params.require(:friendship).permit(:accepter_id)
		# {description: "my desc", receiver_id: 55}
	end

	def method_name
		
	end

end