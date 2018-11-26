class Store < ApplicationRecord
  has_many :products
  has_many :orders
  geocoded_by :address
  after_validation :geocode
end
