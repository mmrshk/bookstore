class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable,
        :confirmable, :omniauthable,
        :omniauth_providers => [:facebook]

  has_many :reviews, dependent: :destroy
  has_many :addresses, dependent: :destroy

  has_many :orders, dependent: :destroy
  has_many :line_items, through: :orders, dependent: :destroy
  has_many :books, through: :line_items, dependent: :destroy

  has_one :billing, dependent: :destroy
  has_one :shipping, dependent: :destroy
  has_one :credit_card, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.skip_confirmation!
    end
  end
end
