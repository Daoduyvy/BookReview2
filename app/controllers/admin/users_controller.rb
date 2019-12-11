# frozen_string_literal: true

class Admin::UsersController < ApplicationController
    layout 'admin'
    before_action :authenticate_user!, except: [:index]
    before_action :find_user, only: %i[show edit]
  
    def new
      @user = User.new
    end
  
    def index
      @users = User.paginate(page: params[:page], per_page: 3).order(created_at: :desc)
      if params[:term].present?
        @users = @users.search_by_email(params[:term]).paginate(page: params[:page], per_page: 6)
      end
      @current_user = User.find_by_id(session[:current_user_id])
    end
  
    def edit; end
  
    def show; end
  
    def update
      redirect_to book_path(@book) if @review.update(review_params)
    end
  
    private
  
    def find_user
      @user = User.find(params[:id])
    end
  end
  