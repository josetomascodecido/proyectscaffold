class Store < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :users
  geocoded_by :address
  after_validation :geocode
end
