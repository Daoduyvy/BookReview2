# frozen_string_literal: true

class AddBookIdToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :book_id, :integer
  end
end
