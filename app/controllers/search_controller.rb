class SearchController < ApplicationController
	
	def search
	# use params[:search] to preform
		if params[:search]
			@users= User.all.search(params[:search])
		else
			@users = User.all.order('created_at DESC')
		end
	end


end