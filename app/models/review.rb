# frozen_string_literal: true

class Review < BaseModel
  belongs_to :user
  belongs_to :book
end
