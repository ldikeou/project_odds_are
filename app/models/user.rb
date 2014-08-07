class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

has_many :sent_friendships, foreign_key: "requester_id", dependent: :destroy, class_name: 'Friendship'
has_many :received_friendships, foreign_key: "accepter_id", dependent: :destroy, :class_name => 'Friendship'
# has_many :friends, through: :friendships, class_name: "User"
has_many :sent_bids, foreign_key: :sender_id, class_name: "Bid", dependent: :destroy, class_name: 'Bid'
has_many :received_bids, foreign_key: :receiver_id, class_name: "Bid", dependent: :destroy, class_name: 'Bid'

has_many :activities
# current_user.challenged_bids


has_attached_file :profile_pic, :styles => { :medium => "300x300>", :thumb => "45x45#" }, 
	:default_url => ":style/default.png"
	# have thumb/default and medium/default
validates_attachment_content_type :profile_pic, :content_type => /\Aimage\/.*\Z/


	#  SELECT "friendships".* FROM "friendships"  
	#    WHERE "friendships"."requester_id" = ? 
	#      or "friendships"."accepter_id" = ?  [["requester_id", 2], ["accepter_id", 2]]
	def friendships
		t = Friendship.arel_table
		Friendship.where(t[:requester_id].eq(id).or(t[:accepter_id].eq(id)))
	end

	def bids
		t = Bid.arel_table
		Bid.where(t[:sender_id].eq(id).or(t[:receiver_id].eq(id)))
	end


	def self.search(query)
		return all unless query
		search_condition = "%" + query + "%"
		where( "first_name LIKE ?", search_condition)
	end

	def search(query)
		return [] if query.blank?
		friends.select {|f| f.first_name.downcase.include?(query.downcase) }
	end
		
	def friends
		friendships = Friendship.where(Friendship.arel_table[:requester_id].eq(id).or(
			Friendship.arel_table[:accepter_id].eq(id))
		).where(Friendship.arel_table[:status].eq("accepted"))
		friendships.map do |friendship|
			if friendship.requester_id == id
				friendship.accepter
			else
				friendship.requester
			end
		end
	end      

	def pending_friendships
		friendships = Friendship.where(Friendship.arel_table[:requester_id].eq(id).or(
			Friendship.arel_table[:accepter_id].eq(id))
		).where(Friendship.arel_table[:status].eq("pending"))
		friendships
	end

	def pending_friends
		friendships = Friendship.where(Friendship.arel_table[:requester_id].eq(id).or(
			Friendship.arel_table[:accepter_id].eq(id))
		).where(Friendship.arel_table[:status].eq("pending"))
		friendships.map do |friendship|
			if friendship.requester_id == id
				friendship.accepter
			else
				friendship.requester
			end
		end
	end

	# def pending_friendships
	# 	binding.pry
	# 	Friendship.where(accepter_id: self.id, status: "pending")
	# end


	def friends?(other_user)
		self.friends.include?(other_user)
	end

	def pending_friends?(other_user)
		self.pending_friendships.include?(other_user)
	end

	def notifications
		notifications = requested_notifications + accepted_notifications + 
		bid_requested_notifications + challengers_guess_notifications +
		recip_results_notifications + challenge_completed_notifications
	end

	def accepted_notifications
		friendships = sent_friendships.where(status: "accepted")
		notifications = []
		friendships.each do |friendship|
			friendship.friendship_notifications.each do |notification|
				if notification.status == "unread"
					notifications << notification
				end
			end
		end
		notifications
	end

	def requested_notifications
		friendships = received_friendships.where(status: "pending")
		notifications = []
		friendships.each do |friendship|
			friendship.friendship_notifications.each do |notification|
				if notification.status == "unread"
					notifications << notification
				end
			end
		end
		notifications
	end

	

	def bid_requested_notifications
		bids = received_bids.where(completion_status: "ready_for_range")
		notifications =[]
		bids.each do |bid|
			bid.bid_notifications.each do |notification|
				if notification.status == "unread"
					notifications << notification
				end
			end
		end
		notifications
	end

	def challengers_guess_notifications
		bids = sent_bids.where(completion_status: "ready_for_challenger")
		notifications =[]
		bids.each do |bid|
			bid.bid_notifications.each do |notification|
				if notification.status == "unread"
					notifications << notification
				end
			end
		end
		notifications
	end

	def recip_results_notifications
		res1 = received_bids.where(completion_status: "determine_winner")
		res2 = received_bids.where(completion_status: "lost")
		bids = res1 + res2
		notifications =[]
		bids.each do |bid|
			bid.bid_notifications.each do |notification|
				if notification.status == "unread"
					notifications << notification
				end
			end
		end
		notifications
	end


	def create_activity(item, action)
		# scoped automatically to the user instance
		activity activities.new
		activity.targetable = item
		activity.action = action
		activity.save
		# returns the actual activity instance instead of the true or false
		activity
	end

	def challenge_completed_notifications
		bids = sent_bids.where(completion_status: "completed")
		notifications =[]
		bids.each do |bid|
			bid.bid_notifications.each do |notification|
				if notification.status == "unread"
					notifications << notification
				end
			end
		end
		notifications
	end


end
