class FriendshipsController < ApplicationController
	before_action :authenticate_user!

	def index
		@friends = current_user.friends

		@friend_id=params[:id]

	end


	def edit
		# @pending_friendships = current_user.pending_friendships
		@friend_requests= current_user.friend_requests
		# @pending_friends= current_user.pending_friends
	end

	def new

		@friendship = Friendship.new
		if params[:q]
			@users = User.search(params[:q]) 
			@users -= [current_user]
		end
		
	end

	def create
		Friendship.request(current_user, User.find(params[:accepter_id]))
		redirect_to user_path(current_user)
	end

	def destroy
		@friendship = Friendship.find(params[:id])
		@friendship.destroy
		redirect_to friendships_path
	end


	def update
		f = Friendship.find(params[:id])
		f.update(status: params[:status])

		if f.status == "accepted" 
			f.friendship_notifications.create(status: "unread", message: "#{f.accepter.first_name} has accepted your friend request")
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