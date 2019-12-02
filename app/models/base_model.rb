class BaseModel < ActiveRecord::Base
  self.abstract_class = true
  scope :paginates, -> (per_page, page) { offset(per_page*(page-1)).limit(per_page) }
end
