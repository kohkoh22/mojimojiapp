class Post < ApplicationRecord
  [:vocab, :definition, :example, :image].each do |v|
    validates v, presence: true
  end
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :comments
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  is_impressionable
  

  def previous
    Post.order('created_at desc, id desc').where('created_at <= ? and id < ?', created_at, id).first
  end

  def next
    Post.order('created_at desc, id desc').where('created_at >= ? and id > ?', created_at, id).reverse.first
  end

  def self.search(search)
    if search != ""
      Post.where('vocab LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end

end
