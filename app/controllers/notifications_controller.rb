class NotificationsController < ApplicationController
	before_action :authenticate_user!


	def index
		@an= current_user.accepted_notifications
	end


end