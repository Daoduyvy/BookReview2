class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_user, only:[:show,:edit]

	def new
		@user = User.new
	end

	def index
		@users = User.all.order(created_at: :desc)
	end

  def edit

  end

	def create

	end
  def show
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end
