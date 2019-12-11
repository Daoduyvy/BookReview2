# frozen_string_literal: true

class User < BaseModel
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :reviews
  has_many :active_follows, class_name: 'Follow',
                            foreign_key: 'follower_id',
                            dependent: :destroy
  has_many :passive_follows, class_name: 'Follow',
                            foreign_key: 'followed_id',
                            dependent: :destroy
  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower
  # Follows a user.
  def follow(other_user)
    active_follows.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_follows.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  private
end
