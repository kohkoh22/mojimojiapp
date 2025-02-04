class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy 
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy 
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  mount_uploader :image, ImageUploader
  is_impressionable

  [:nickname, :email, :password, :profile].each do |v|
    validates v, presence: true
  end
  validates :nickname, uniqueness: true
  validates :nickname, length: { maximum: 8 }

  def self.search(search)
    if search != ''
      User.where('nickname LIKE(?)', "%#{search}%")
    else
      User.all
    end
  end

  def already_liked?(post)
    likes.exists?(post_id: post.id)
  end

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com', nickname: 'ゲスト', profile:'ゲストです。趣味はプログラミングです。') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

end
