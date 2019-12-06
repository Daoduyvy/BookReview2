class Book < BaseModel
  belongs_to :user
  belongs_to :category
  has_many :reviews
  has_attached_file :book_img, :styles => { :book_index => "300x300>", :book_show => "100x100>" }, default_url: "/images/:style/missing.png",
  					:path => ":rails_root/public/uploadfile/:id/:style/:filename",
  					:url => "/uploadfile/:id/:style/:filename"
  validates_attachment_content_type :book_img, :content_type => /^image\/(png|gif|jpeg)/

  scope :search_title, -> (title) { where('title like ?', "%#{title}%")}
  scope :search_category , -> (category_id) { where('category_id like ?' , "%#{category_id}%")}
end
