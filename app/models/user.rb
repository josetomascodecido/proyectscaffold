class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_many :orders
  # has_many :products, through: :orders
  # scope -> { ordes.where(payr) }
  enum role:[:admin, :user, :visit, :local_admin]
  geocoded_by :address
  after_validation :geocode
  def cart
    orders.where(payed: false)
  end
end
