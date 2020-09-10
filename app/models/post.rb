class Post < ApplicationRecord
  [:vocab, :definition, :example, :image].each do |v|
    validates v, presence: true
  end
  mount_uploader :image, ImageUploader
  belongs_to :user
end
