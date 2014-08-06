class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

has_many :sent_friendships, foreign_key: "requester_id", dependent: :destroy, class_name: 'Friendship'
has_many :received_friendships, foreign_key: "accepter_id", dependent: :destroy, :class_name => 'Friendship'
# has_many :friends, through: :friendships, class_name: "User"
has_many :sent_bids, foreign_key: :sender_id, class_name: "Bid"
has_many :received_bids, foreign_key: :receiver_id, class_name: "Bid"

has_many :activities
# current_user.challenged_bids


has_attached_file :profile_pic, :styles => { :medium => "300x300>", :thumb => "40x40#" }, 
	:default_url => "default.png"
validates_attachment_content_type :profile_pic, :content_type => /\Aimage\/.*\Z/


	#  SELECT "friendships".* FROM "friendships"  
	#    WHERE "friendships"."requester_id" = ? 
	#      or "friendships"."accepter_id" = ?  [["requester_id", 2], ["accepter_id", 2]]
	def friendships
		t = Friendship.arel_table
		Friendship.where(t[:requester_id].eq(id).or(t[:accepter_id].eq(id)))
	end

	def self.search(query)
		search_condition = "%" + query + "%"
		where( "first_name LIKE ?", search_condition)
	end

	def search(query)
		friends.select {|f| f.first_name.include?(query) }
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
		friendships.map do |friendship|
			if friendship.requester_id == id
				friendship.accepter
			else
				friendship.requester
			end
		end
	end


	def friends?(other_user)
		self.friends.include?(other_user)
	end

	def pending_friends?(other_user)
		self.pending_friendships.include?(other_user)
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

	def notifications
		notifications = requested_notifications + accepted_notifications
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

	
end
