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
		frienship.friendship_notifications.create(status: "unread", message: "#{requester.username} sent you a friend request")
	end

	def pending_friendships
		Friendship.where(accepter_id: self.id, status: "pending")
	end

	# def self.update_status(status, requester, accepter)
	# 	frienship = Friendship.where(requester: "requester", accepter: "accepter")
	# 	if status = "accept" do
	# 		frienship.status = "accepted"
	# 	else
	# 		frienship.destroy;
	# 	end
	# end


end
