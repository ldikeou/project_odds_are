class UsersController < ApplicationController
	 before_action :authenticate_user!

	 def index
	 	if params[:q]
			@users = User.search(params[:q])
			@users -= [current_user]
		end
	 end

	 def search()
		@users= User.all.search(params[:search])
	 end

	 def show
	 	# i want all the bids that the user whose profile we are 
	 	# looking is associated receiver or challenger with and whose status is completed
	 	@bids = current_user.bids.where(completion_status: "completed").order('updated_at DESC')
	 	@other_user = User.find(params[:id])
	 	

	 	# return redirect_to new_friendship_path unless 
	 end

	 # def update
	 # 	if @user.update(about_params)
	 # 		format.html {redirect to @about, notice: 'About completed! Legend plus one'}
	 # 	else
	 # 		format.html {render :edit}
	 # 	end
	 # end

	 private
	 def set_user
	 	@user = User
	 end

end