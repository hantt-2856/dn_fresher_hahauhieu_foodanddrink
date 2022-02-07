class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :ratings, dependent: :destroy

  enum role: {user: 0, admin: 1}
end
