class Review < ApplicationRecord
    belongs_to :user
    belongs_to :book
    scope :paginate_review, -> (per_page, page) { offset(per_page*(page-1)).limit(per_page) }
end
