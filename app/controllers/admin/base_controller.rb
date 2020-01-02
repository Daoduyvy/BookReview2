class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!, :set_locale

  def index

    @users = User.all
    @books = Book.all
    @reviews = Review.all
    @categories = Category.all
    @book_by_month = Book.group_by_month_of_year(:created_at, format: "%B %d, %Y").count
    @book_by_category= Category.all.map{|c| [c.name , Book.where(category_id: c.id).count] }
  end

  def set_locale
    I18n.default_locale = :en
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
                      locale : I18n.default_locale
  end


end