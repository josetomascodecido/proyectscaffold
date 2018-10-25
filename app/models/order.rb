class Order < ApplicationRecord
  belongs_to :user
  belongs_to :store
  has_many :products

end
