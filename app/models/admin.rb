class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  WillPaginate.per_page = 3
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
