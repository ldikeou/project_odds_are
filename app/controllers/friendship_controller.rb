class FriendshipsController < ApplicationController


	def create
		Friendship.request(current_user, :accepter)
	end


	def update
		Friendship.updateStatus(:status, :requester, :accepter)
	end



end