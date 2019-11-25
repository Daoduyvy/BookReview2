class BooksController < ApplicationController

	before_action :find_book, only: [:show,:edit,:update,:destroy]

	def index
		@books = Book.all.order("created_at DESC")
	end

	def new
		@book = Book.new
	end

	def show
		
	end

	def update
		if @book.update(book_params)
			redirect_to book_path(@book)
		else
			render 'edit'
		end	
	end

	def create
		@book = Book.new(book_params)
		if @book.save
			redirect_to root_path
		else
			render 'new'	
		end
	end

	private 
		def book_params
			params.require(:book).permit(:title,:publish_date,:author)
		end
		def find_book
			@book = Book.find(params[:id])
		end
end
