class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :store
  has_many :orders
end
