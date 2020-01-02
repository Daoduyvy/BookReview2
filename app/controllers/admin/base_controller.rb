class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!, :set_locale

  def index

    @users = User.all
    @books = Book.all
    @reviews = Review.all
    @categories = Category.all
  end

  def set_locale
    I18n.default_locale = :en
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
                      locale : I18n.default_locale
  end
end