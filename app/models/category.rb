# frozen_string_literal: true

class Category < BaseModel
  has_many :books
end
