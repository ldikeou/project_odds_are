class Friendship < ActiveRecord::Base
	# f = Friendship.new
	# f.requester

	belongs_to :requester, :class_name => 'User'
	belongs_to :accepter, :class_name => 'User'

	def self.request(requester , accepter)
		return false if (requester == accepter) 
		friendship = Friendship.where(requester: requester, accepter: accepter).first_or_create do |f|
			f.status = "pending"
		end

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
