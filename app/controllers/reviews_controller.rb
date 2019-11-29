class ReviewsController < ApplicationController
  before_action :find_book
  before_action :find_review, only: [:edit, :update, :destroy,:show]
  PER_PAGE = 2
def new
   @review = @book.reviews.build
 end

def index
  @page = (params[:page] || 1 ).to_i
  @reviews = Review.paginate_review(PER_PAGE,@page)
end

def create
  @review = @book.reviews.build(review_params)
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
