class AdminController < ApplicationController
	def home
		@curr_admin = current_admin
	end
end
