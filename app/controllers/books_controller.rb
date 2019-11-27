class BooksController < ApplicationController

  before_action :find_book, only: [:show,:edit,:update,:destroy]
  
  BOOK_SIZE = 2
  def index
    @page = (params[:page] || 1 ).to_i
    @books = if params[:term]
      Book.where('title LIKE ?', "%#{params[:term]}%").offset(BOOK_SIZE*@page-1).limit(BOOK_SIZE)
    else
      Book.offset(BOOK_SIZE*@page).limit(BOOK_SIZE)
    end

  end

  def new
    @book = current_user.books.build
    @categories = Category.all.map {| c | [c.name, c.id] }
  end  

  def show
    @reviews = @book.reviews  
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      @categories = Category.all.map { |c| [c.name, c.id] }
      render :edit
    end 
  end
  def edit
    @categories = Category.all.map { |c| [c.name, c.id] }
  end
  def create
    @book = current_user.books.build(book_params)
    @book.category_id = params[:category_id]
    if @book.save
      redirect_to root_path
    else
      @categories = Category.all.map { |c| [c.name, c.id] }
      render :new  
    end
  end



  private 
  def book_params
    params.require(:book).permit(:title,:publish_date,:author,:category_id, :book_img,:description)
  end
  def find_book
    @book = Book.find(params[:id])
  end
end
