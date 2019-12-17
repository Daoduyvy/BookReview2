# frozen_string_literal: true

class Admin::ReviewsController < ApplicationController
  layout 'admin'
  before_action :find_review,:find_book,only: %i[edit create update destroy show]

  def new
    @review = @book.reviews.build
  end

  def index
    @page = (params[:page] || 1).to_i
    @review = Review.new
    @reviews = Review.paginate(page: params[:page], per_page: 2).order(created_at: :desc)
    @reviews.each do |review|
      @user = User.find(review.user_id)
      @book = Book.find(review.book_id)
    end
    @users =  User.pluck(:email, :id)
    @books =  Book.pluck(:title, :id)
  end

  def create
    @review = @book.reviews.build(review_params)
    @review.book_id = @book.id
    @review.user_id = current_user.id
    respond_to do |format|
      if @review.save
        format.html { redirect_to admin_book_review_path }
        format.js
      else
        format.html { redirect_to admin_book_review_path }
      end
    end
  end

  def show; end

  def edit; 
  end

  def update
    redirect_to admin_book_review_path if @review.update(review_params)
  end

  def destroy
    @review.destroy
    redirect_to admin_reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment,:book_id,:user_id)
  end


  def find_user
    @user = User.find(params[:user_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end

  def find_book
    @book = Book.find(params[:book_id])
  end
end
