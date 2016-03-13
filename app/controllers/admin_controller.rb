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

    def new
        password = rand(36**10).to_s(36)
        puts password
        admin = Admin.new(email: params[:email], password:password, password_confirmation:password)
        puts admin.save!
        puts admin
        puts alert
        @alert = "Added #{params[:email]} as an admin with temporary password '#{password}'. (will add email sending soon)"
        render_index(alert)
    end

    def destroy
        to_destroy = Admin.find(params[:id])
        email = to_destroy.email
        to_destroy.destroy
        @alert = "Deleted #{email} from admins."
        render_index(alert)
    end

    private

    def render_index(alert)
        @curr_admin = current_admin
        @page = 'admins'
        @admins = Admin.all
        render :index
    end
end
