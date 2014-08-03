class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

has_many :friendships

has_attached_file :profile_pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
	:default_url => "default.png"
validates_attachment_content_type :profile_pic, :content_type => /\Aimage\/.*\Z/


	def self.search(query)
		search_condition = "%" + query + "%"
		where( "first_name like ?", search_condition)
	end

         
end
