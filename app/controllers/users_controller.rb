class UsersController < ApplicationController
	 before_action :authenticate_user!
	 
	 def index
	 	@user =User.all
	 end

	 def show
	 	
	 end

	 def new
	 end

	 def update
	 	binding.pry
	 	if @user.update(about_params)
	 		format.html {redirect to @about, notice: 'About completed! Legend plus one'}
	 	else
	 		format.html {render :edit}
	 	end
	 end



	 private
	 def set_user
	 	# @user = User.
	 end
end