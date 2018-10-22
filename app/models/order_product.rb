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
    if product.update_stock(quantity)
      return self.save
    else
      return false
    end
  end

  def edit_quantity(quantity_ordered)
    if product.available?(quantity_ordered)
      new_quantity = quantity + quantity_ordered
      return self.update(quantity: new_quantity)
    else
      return false
    end
  end
end
