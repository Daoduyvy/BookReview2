# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :find_book, only: %i[show edit update destroy]
  WillPaginate.per_page = 1

  def index
    @page = (params[:page] || 0).to_i
    @books = Book.paginate(page: params[:page], per_page: 6).order(created_at: :desc)
    if params[:term].present?
      @books = @books.search_title(params[:term]).where(category_id: params[:category_id]).paginate(page: params[:page], per_page: 6)
    end
    @categories = Category.pluck(:name, :id)
  end

  def new
    @book = current_user.books.build
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def show
    @reviews = @book.reviews.paginate(page: params[:page]).order(created_at: :desc)
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
