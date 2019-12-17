class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  def new
  end
  
  def index
      @book = Book.new
      @users = User.all
      @books = Book.paginate(page: params[:page], per_page: 2).order(created_at: :desc)
      @categories = Category.pluck(:name, :id)
  end

  end