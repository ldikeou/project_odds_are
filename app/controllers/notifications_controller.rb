class NotificationsController < ApplicationController
	before_action :authenticate_user!


	def index
		@notifications= current_user.notifications
	end

	def show
		@notification = Notification.find(params[:id])
		@notification.status = "read"
		if @notification.type == "FriendshipNotification"
			@friendship = Friendship.find(@notification.notifiable_id)
			redirect_to user_path(@friendship.accepter_id)
		else
			redirect_to bids_path
		end
	end



end