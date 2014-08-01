class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

has_many :friendships, foreign_key: "requester_id"
# has_many :friends, through: :friendships, class_name: "User"


has_attached_file :profile_pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
	:default_url => "/images/:style/missing.png"
validates_attachment_content_type :profile_pic, :content_type => /\Aimage\/.*\Z/


	def self.search(query)
		search_condition = "%" + query + "%"
		where( "first_name like ?", search_condition)
	end

	def friends
		friendships = friendships.where(arel_table[:requester_id].eq(current_user.id).or(arel_table[:accepter_id].eq(current_user.id))).where(arel_table[:accepter_id].not_eq(nil))
		friendships.map do |friendship|
			if friendship.requester_id == id
				friendship.accepter
			else
				friendship.requester
			end
		end
		friendships
	end      


end
