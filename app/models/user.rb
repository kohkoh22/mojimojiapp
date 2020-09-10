class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  def self.search(search)
    if search != ""
      User.where('nickname LIKE(?)', "%#{search}%")
    else
      User.all
    end
  end

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

end
