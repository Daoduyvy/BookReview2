class CategoriesController < ApplicationController

  before_action :find_category, only: %i[show edit]

  def new
    @categories = Category.new
  end

  def index
    @categories = Category.all.order(created_at: :desc)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    return unless @category.update(category_params)
      redirect_to book_path(@book)
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end

end
