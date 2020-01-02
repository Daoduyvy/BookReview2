class Admin::ChartsController < Admin::BaseController
  layout 'admin'

  def index
    @book_by_month = Book.group_by_month(:created_at, format: "%d %m %Y").count
    @book_by_category= Category.all.map{|c| [c.name , Book.where(category_id: c.id).count] }
  end
  end
