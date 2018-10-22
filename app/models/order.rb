class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  accepts_nested_attributes_for :user

  validates :user, presence: true
  # validates :order_products, presence: true, uniqueness: true
  validates :status, presence: true
  validates :status, inclusion: { in: %w(pending paid shipped),
    message: "%{value} is not a valid order status" }

  def total
    return order_products.map { |op| op.valid? ? op.subtotal : 0 }.sum
  end

  def add_product(product, quantity)
    # check if product is already in cart
    current_op = order_products.find_by(product_id: product.id)

    if current_op # if so, edit quantity within existing orderproduct
      new_quantity = current_op.quantity + quantity
      current_op.edit_quantity(new_quantity)
    else # if not, add new orderproduct
      current_op = self.order_products.create(product_id: product.id, quantity: quantity, order_id: self.id)
    end
  end

  def edit_quantity(op, new_quantity)
    op.edit_quantity(new_quantity)
  end

  def submit_order
    self.status = "paid"
    order_products.each { |op| op.update_stock }
    self.save
    return self.id
  end
end
