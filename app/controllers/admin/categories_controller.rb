class Admin::CategoriesController < Admin::BaseController
  layout 'admin'
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :find_category, only: %i[show edit destroy update ]

  def index
    @category = Category.new
    @categories = Category.order(created_at: :desc).paginate(page: params[:page])
    @categories = Category.search_name(params[:term]).order(created_at: :desc).paginate(page: params[:page]) if params[:term].present?
    respond_to do |format|
      format.html
      format.js {}
    end
  end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.js
      else
        format.js { render js: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def show;
  end

  def edit;
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.js
      else
        format.js { render js: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to { |format|
      format.js
    }
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end

end
