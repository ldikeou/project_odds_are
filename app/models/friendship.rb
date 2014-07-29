class Friendship < ActiveRecord::Base
	# f = Friendship.new
	# f.requester

	belongs_to :requester
	belongs_to :accepter


end
