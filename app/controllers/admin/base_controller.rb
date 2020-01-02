class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!, :set_locale

  def index
    @book = Book.new
    @users = User.all
    @books = Book.paginate(page: params[:page], per_page: 2).order(created_at: :desc)
    @categories = Category.pluck(:name, :id)
  end

  private

  def set_locale
    I18n.default_locale = :en
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
                      locale : I18n.default_locale
  end


end