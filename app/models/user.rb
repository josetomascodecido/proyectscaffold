class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_many :orders, dependent: :destroy
  # has_many :products, through: :orders
  # scope -> { ordes.where(payr) }
  enum role:[:admin, :local_admin, :user]
  geocoded_by :address
  after_validation :geocode
  belongs_to :store, optional: true
  has_many :billings


  def cart
    orders.where(payed: 0)
  end
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end
end
