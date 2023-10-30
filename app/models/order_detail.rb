class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum production_status: { waiting: 0, start: 1, making: 2, done: 3 }

  def subtotal
    purchase_price * amount
  end
end
