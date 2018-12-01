class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :store
  has_many :orders, dependent: :destroy
  # has_many :users, through: :orders
end
