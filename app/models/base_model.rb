class BaseModel < ActiveRecord::Base
  self.abstract_class = true
  scope :paginates, -> (per_page, page) { offset(per_page*(page-1)).limit(per_page) }
  scope :search_title, -> (title) { where('title like ?', "%#{title}%")}
  scope :search_name, -> (name) { where('name like ?', "%#{name}%")}
  scope :search_by_email, -> (title) { where('email like ?', "%#{title}%")}
  scope :group_by_type, -> (type) {
    case type
    when type = "week"
      group("DATE_FORMAT(activated_at,'%v-%x')").count
    when type = "month"
      group("DATE_FORMAT(activated_at,'%b-%x')").count
    when type = "year"
      group("DATE_FORMAT(activated_at,'%x')").count
    end
  }
end
