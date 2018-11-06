class Billing < ApplicationRecord
  has_many :orders
end
