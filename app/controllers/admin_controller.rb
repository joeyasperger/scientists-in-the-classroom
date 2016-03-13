class AdminController < ApplicationController

    before_action :authenticate_admin!

	def home
		@curr_admin = current_admin
	end

    def index
        @curr_admin = current_admin
        @page = 'admins'
        @admins = Admin.all
    end

end
