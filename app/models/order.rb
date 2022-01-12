class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy

  scope :sort_by_create_at, ->{order :created_at}

end
