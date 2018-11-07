class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  # has_many :products, through: :orders
  # scope -> { ordes.where(payr) }
  enum role:[:admin, :user, :visit, :local_admin]
  def cart
    orders.where(payed: false)
  end
end
