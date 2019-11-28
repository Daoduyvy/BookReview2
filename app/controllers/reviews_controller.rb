class ReviewsController < ApplicationController
  before_action :find_book
  before_action :find_review, only: [:edit, :update, :destroy,:show]
  REVIEW_SIZE = 2
def new
   @review = Review.new
 end

def index
  @page = (params[:page] || 1 ).to_i
  @reviews =  Review.offset(REVIEW_SIZE*@page).limit(REVIEW_SIZE)
end

def create
  @review = Review.new(review_params)
  @review.book_id = @book.id
  @review.user_id = current_user.id
  if @review.save
    redirect_to book_path(@book)
  end
end

def show

end

def edit

end

def update
  if @review.update(review_params)
    redirect_to book_path(@book)
  end
end

def destroy
  @review.destroy
  redirect_to book_path(@book)
end

private
def review_params
  params.require(:review).permit(:rating,:comment)
end
def find_book
  @book = Book.find(params[:book_id])
end
def find_review
  @review = Review.find(params[:id])
end
end
