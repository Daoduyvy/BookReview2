# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :find_book 
  before_action :find_review, only: %i[edit update destroy show]
  WillPaginate.per_page = 2
  def new
    @review = @book.reviews.build
  end

  def index
    @page = (params[:page] || 1).to_i
    @reviews = @book.reviews.paginate(page: params[:page], per_page: 2).order(created_at: :desc)
  end

  def create
    @review = @book.reviews.build(review_params)
    @review.book_id = @book.id
    @review.user_id = current_user.id
    redirect_to book_path(@book) if @review.save
  end

  def show; end

  def edit; end

  def update
    redirect_to book_path(@book) if @review.update(review_params)
  end

  def destroy
    @review.destroy
    redirect_to book_path(@book)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def find_book
    @book = Book.find(params[:book_id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end
end
