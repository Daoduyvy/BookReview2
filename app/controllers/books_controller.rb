# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :find_book, only: %i[show edit update destroy]
  WillPaginate.per_page = 3

  def index
    @page = (params[:page] || 0).to_i
    @books = Book.order(created_at: :desc).paginate(page: params[:page])
    @books = @books.search_title(params[:term]).where(category_id: params[:category_id]).paginate(page: params[:page])  if params[:term].present?
    @categories = Category.pluck(:name, :id)


  end

  def new
    @book = current_user.books.build
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def show
    @users = User.all.order(created_at: :desc)
    @reviews = @book.reviews..order(created_at: :desc).page(params[:page])
    respond_to do |format|
      format.js
    end
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      @categories = Category.all.map { |c| [c.name, c.id] }
      render :edit
    end
    respond_to { |format|
      if @book.update(book_params)
        format.js
      else
        format.js { render json: @book.errors.full_messages,
                             status: :unprocessable_entity }
      end

    }
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

  def destroy
    @book.reviews.destroy_all
    @book.destroy
    redirect_to root_path
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
