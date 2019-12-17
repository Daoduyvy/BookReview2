# frozen_string_literal: true

class Admin::BooksController < Admin::BaseController
  layout 'admin'
  
  before_action :find_book, only: %i[show edit update destroy]
  WillPaginate.per_page = 10
  
  def index
    @page = (params[:page] || 0).to_i
    @book = current_user.books.build
    @books = Book.paginate(page: params[:page]).order(created_at: :desc)
    if params[:term].present?
      @books = @books.search_title(params[:term]).where(category_id: params[:category_id]).paginate(page: params[:page])
    end
    @categories = Category.pluck(:name, :id)

    respond_to do |format|
      format.html 
      format.json {render :json => @book}
      format.js
   end
  end

  def show
    @users = User.all.order(created_at: :desc)
    @reviews = @book.reviews.page(params[:page]).per(3).order(created_at: :desc)
    respond_to do |format|
      format.html # index.html.erb
      format.json {render :json => @review}
      format.js
      format.xml
   end
  end

  def update
    if @book.update(book_params)
      redirect_to admin_books_path
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
    if @book.save
      redirect_to admin_books_path
    else
      @categories = Category.all.map { |c| [c.name, c.id] }
    end
  end

  def destroy
    @book.reviews.destroy_all
    @book.destroy
    redirect_to admin_books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :publish_date, :author, :category_id,
                                 :book_img, :description)
  end

  def find_book
    @book = Book.find(params[:id])
  end
end
