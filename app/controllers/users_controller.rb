class UsersController < ApplicationController

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