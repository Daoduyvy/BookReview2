# frozen_string_literal: true

class Admin::BooksController < Admin::BaseController
  layout 'admin'
  before_action :set_locale
  before_action :find_book, only: %i[show edit update destroy]

  def index
    @page = (params[:page] || 0).to_i
    @book = current_user.books.build
    @books = Book.order(created_at: :desc).paginate(page: params[:page])
    @books = @books.search_title(params[:term]).where(category_id: params[:category_id]) if params[:category_id].present?
    @books = @books.search_title(params[:term])if params[:term].present?
    @categories = Category.pluck(:name, :id)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @users = User.all.order(created_at: :desc)
    @reviews = @book.reviews.page(params[:page]).per(3).order(created_at: :desc)
  end

  def update
    @book = Book.find(params[:id])
    respond_to do |format|
      if @book.update(book_params)
        format.js
      else
        format.js { render js: @book.errors.full_messages,
                             status: :unprocessable_entity }
      end
    end
  end

  def edit
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    @book = current_user.books.build(book_params)
    @book.category_id = params[:category_id]

    respond_to do |format|
      if @book.save
        format.js
      else
        format.js { render js: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.reviews.destroy_all
    @book.destroy
    respond_to do |format|
      format.js
    end
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
