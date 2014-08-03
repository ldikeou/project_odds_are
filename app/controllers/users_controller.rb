class UsersController < ApplicationController
	 before_action :authenticate_user!

	 def index
	 	if params[:q]
			@users = User.search(params[:q])
			@users.delete current_user
		end
	 end

	 def search()
		@users= User.all.search(params[:search])
		@users.delete current_user
	 end

	 def show
	 	@user_to_show = User.find(params[:id])
	 	return redirect_to new_friendship_path unless current_user.friends.include?(@user_to_show) ||
	 	@user_to_show == current_user
	 end

	 # def update
	 # 	# binding.pry
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