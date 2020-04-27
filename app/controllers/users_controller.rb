class UsersController < ApplicationController
	  before_action :authenticate_user!
	  before_action :correct_user, only: [:edit, :update]
	def show
		@user = User.find(params[:id])
		@post = Post.new
		@posts = @user.posts.page(params[:page]).reverse_order
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update(user_params)
		redirect_to user_path
	end

	private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end

	def correct_user
		user = User.find(params[:id])
		if current_user!= user
		   redirect_to user_path
		end
    end
end
