class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

has_many :friendships


	def self.search(query)
		search_condition= "%" + query + "%"
		where( "username like ?", "search_condition")
	end

         
end
