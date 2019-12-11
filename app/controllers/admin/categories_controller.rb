class Admin::CategoriesController < ApplicationController
  layout 'admin'
  before_action :find_category, only: %i[show edit]

  def new
    @categories = Category.new
  end

  def index
    @category = Category.new
    @categories = Category.paginate(page: params[:page], per_page: 3).order(created_at: :desc)
    if params[:term].present?
      @categories = @categories.search_name(params[:term]).paginate(page: params[:page], per_page: 6)
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @category.update(category_params)
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
