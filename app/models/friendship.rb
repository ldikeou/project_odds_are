class Friendship < ActiveRecord::Base
	# f = Friendship.new
	# f.requester

	belongs_to :requester, :class_name => 'User'
	belongs_to :accepter, :class_name => 'User'


end
