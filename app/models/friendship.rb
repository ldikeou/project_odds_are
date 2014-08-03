class Friendship < ActiveRecord::Base
	# f = Friendship.new
	# f.requester

	belongs_to :requester, :class_name => 'User'
	belongs_to :accepter, :class_name => 'User'

	# def self.request(requester , accepter)
	# 	unless requester == accepter || Friendship.exits?(requester, accepter)
	# 		create(requester: requester, accepter: accepter, status: == "pending")
	# 	end
	# end



	# def self.updateStatus(status, requester, accepter)
	# 	frienship = Friendship.where(requester: "requester", accepter: "accepter")
	# 	if status = "accept" do
	# 		frienship.status = "accepted"
	# 	else
	# 		frienship.destroy;
	# 	end
	# end


end
