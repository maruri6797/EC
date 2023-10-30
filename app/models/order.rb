class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum status: { waiting: 0, paid_up: 1, making: 2, preparing: 3, shipped: 4 }
  enum payment_method: { credit_card: 1, transfer: 2 }

  def billing_amount
    total_price + delivery_charge
  end
end
