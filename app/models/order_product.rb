class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :order, presence: true
  validates :product, presence: true

  def subtotal
    return product.price * quantity
  end

  def update_stock
    product.update_stock(quantity)
    self.save
  end
end
