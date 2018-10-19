class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products, dependent: :destroy

  validates :user, presence: true
  # validates :order_products, presence: true, uniqueness: true
  validates :status, inclusion: { in: %w(shopping paid shipped),
    message: "%{value} is not a valid order status" }

  def total
    return order_products.map { |op| op.valid? ? op.subtotal : 0 }.sum
  end

  def add_product(product, quantity)
   # check if product is already in cart
   current_op = order_products.find_by(product_id: product.id)

   if current_op # if so, edit quantity within existing orderproduct
     current_op.quantity += quantity
   else # if not, add new orderproduct
     current_op = self.order_products.new(product_id: product.id, quantity: quantity, order_id: self.id)
   end

   current_op.save
 end
end
