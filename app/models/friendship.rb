class Friendship < ActiveRecord::Base
	# f = Friendship.new
	# f.requester

	belongs_to :requester, :class_name => 'User'
	belongs_to :accepter, :class_name => 'User'
	has_many :friendship_notifications, as: :notifiable

	def self.request(requester , accepter)
		return false if (requester == accepter) 
		friendship = Friendship.where(requester: requester, accepter: accepter).first_or_create do |f|
			f.status = "pending"
		end
		friendship.friendship_notifications.create(status: "unread", message: "#{requester.username} sent you a friend request")
	end

	


end
