class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments

  def self.search(search)
    if search != ""
      User.where('nickname LIKE(?)', "%#{search}%")
    else
      User.all
    end
  end

end
