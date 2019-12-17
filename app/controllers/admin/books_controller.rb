# frozen_string_literal: true

class Admin::BooksController < Admin::BaseController
  layout 'admin'
  before_action :set_locale
  before_action :find_book, only: %i[show edit update destroy]

  def index
    @page = (params[:page] || 0).to_i
    @book = current_user.books.build
    @books = Book.paginate(page: params[:page]).order(created_at: :desc)
    if params[:term].present?
      if params[:category_id].present?
        @books = @books.search_title(params[:term]).where(category_id: params[:category_id]).paginate(page: params[:page])
      else
        @books = @books.search_title(params[:term]).paginate(page: params[:page])
      end
    end
    @categories = Category.pluck(:name, :id)
    respond_to do |format|
      format.html
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
        format.html { redirect_to admin_book_path }
        format.js { render layout: false }
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
        format.html { redirect_to admin_books_path, notice: 'Book was successfully created.' }
        format.js
      else

        format.html { render action: 'new' }
        format.js { render js: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.reviews.destroy_all
    @book.destroy
    respond_to do |format|
      format.html { redirect_to admin_books_path }
      format.js { render layout: false }
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

  def set_locale
    I18n.default_locale = :en
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
                      locale : I18n.default_locale
  end
end
