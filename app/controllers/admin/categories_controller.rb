class Admin::CategoriesController < ApplicationController
  layout 'admin'
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :find_category, only: %i[show edit destroy update ]

  def index
    @category = Category.new
    if params[:term]
      @categories = Category.search_name(params[:term]).paginate(page: params[:page])
      respond_to do |format|
        format.html { redirect_to admin_categories_path  }
        format.js {}
      end
    else
      @categories = Category.paginate(page: params[:page]).order(created_at: :desc)
    end
  end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_categories_path }
        format.js { render layout: false }
      else
        format.html { redirect_to admin_categories_path }
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
        format.html { redirect_to admin_categories_path }
        format.js { render layout: false }
      else
        format.js { render js: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to { |format|
      format.html { redirect_to admin_categories_path}
      format.js { render layout: false }
    }
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end

  def set_locale
    I18n.default_locale = :en
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
                      locale : I18n.default_locale
  end
end
