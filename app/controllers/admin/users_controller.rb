# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!, except: [:index]
  before_action :find_user, only: %i[show edit]

  def index
    @admin = Admin.new
    @admins = Admin.paginate(page: params[:page], per_page: 3).order(created_at: :desc)
    @user = User.new
    @users = User.paginate(page: params[:page], per_page: 3).order(created_at: :desc)
    if params[:term].present?
      @users = @users.search_by_email(params[:term]).paginate(page: params[:page], per_page: 6)
    end
    @current_user = User.find_by_id(session[:current_user_id])
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: 'User was successfully created.' }
        format.js {render layout: false}
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit;
  end

  def show;
  end

  def update
    redirect_to book_path(@book) if @review.update(review_params)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :admin)
  end
end
