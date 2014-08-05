class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

has_many :friendships, foreign_key: "requester_id", dependent: :destroy
# has_many :friends, through: :friendships, class_name: "User"
has_many :sent_bids, foreign_key: :sender_id, class_name: "Bid"
has_many :received_bids, foreign_key: :receiver_id, class_name: "Bid"

# current_user.challenged_bids


has_attached_file :profile_pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
	:default_url => "default.png"
validates_attachment_content_type :profile_pic, :content_type => /\Aimage\/.*\Z/


	def self.search(query)
		search_condition = "%" + query + "%"
		where( "first_name like ?", search_condition)
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



end
