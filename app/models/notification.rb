class Notification < ActiveRecord::Base
	belongs_to :notifiable, polymorphic: true

	def accepted
		where(status: "accepted")
	end


end