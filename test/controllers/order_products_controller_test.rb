require "test_helper"

describe OrderProductsController do
  let (:dress) { products(:dress) }
  let (:dresses) { order_products(:dresses) }
  let (:mumu) { products(:mumu) }
  let (:pending_order) { orders(:pending_order) }

  describe "create" do
    it "creates a new order product with valid data" do
      # Arrange
      start_count = pending_order.order_products.count

      op_hash = {
        order_product: {
          product_id: mumu.id,
          order: pending_order,
          status: "pending",
          quantity: 2
        }
      }

      # Act

      expect {
        post order_products_path, params: op_hash
      }.must_change 'OrderProduct.count', 1

      # TODO: not saving to pending_order, likely because creating new order in @current_order
      expect(Order.find_by(id: pending_order.id).order_products.count).must_equal (start_count + 1)

      must_respond_with :redirect
      must_redirect_to cart_path

      expect(OrderProduct.last.product.id).must_equal op_hash[:order_product][:product_id]
      expect(OrderProduct.last.order).must_equal op_hash[:order_product][:order]
      expect(OrderProduct.last.status).must_equal op_hash[:order_product][:status]
      expect(OrderProduct.last.quantity).must_equal op_hash[:order_product][:quantity]

      expect(session[:order_id]).must_equal (OrderProduct.last.order.id)
    end

    it "redirects back to the product page and does not update the DB for bogus data" do
      # Arrange
      start_count = pending_order.order_products.count

      op_hash = {
        order_product: {
          product_id: mumu.id,
          order: pending_order,
          status: "pending",
          quantity: 20 # too many
        }
      }

      # Act
      get product_path(mumu.id)
      expect {
        post order_products_path, params: op_hash
      }.wont_change 'OrderProduct.count'

      # TODO: not saving to pending_order, likely because creating new order in @current_order
      expect(Order.find_by(id: pending_order.id).order_products.count).must_equal start_count

      must_respond_with :redirect
      must_redirect_to product_path(mumu.id)
      # TODO: it's actually redirecting to the fallback

      expect(flash[:error]).must_equal "Error: Could not add product to cart"
    end
  end

  describe "update" do
    it "succeeds for valid data and an existing order_product" do
      # Arrange
      start_count = pending_order.order_products.count

      op_hash = {
        order_product: {
          product_id: dresses.product_id,
          order: dresses.order,
          status: dresses.status,
          quantity: 1
        }
      }

      op = OrderProduct.find_by(id: dresses.id)

      expect {
        patch order_product_path(op.id), params: op_hash
      }.wont_change 'OrderProduct.count'

      # TODO: not saving to pending_order, likely because creating new order in @current_order
      expect(Order.find_by(id: pending_order.id).order_products.count).must_equal start_count

      must_respond_with :redirect
      must_redirect_to cart_path

      expect(op.product_id).must_equal op_hash[:order_product][:product_id]
      expect(op.order).must_equal op_hash[:order_product][:order]
      expect(op.status).must_equal op_hash[:order_product][:status]
      expect(op.quantity).must_equal op_hash[:order_product][:quantity]
    end

    it "redirects back to the product page and does not update the DB for bogus data" do
      # Arrange
      start_count = pending_order.order_products.count

      op_hash = {
        order_product: {
          product_id: dresses.product_id,
          order: dresses.order,
          status: dresses.status,
          quantity: 20 # too many
        }
      }

      op = OrderProduct.find_by(id: dresses.id)

      # Act
      get product_path(dress.id)
      expect {
        patch order_product_path(op.id), params: op_hash
      }.wont_change 'OrderProduct.count'

      # TODO: not saving to pending_order, likely because creating new order in @current_order
      expect(Order.find_by(id: pending_order.id).order_products.count).must_equal start_count

      must_respond_with :redirect
      must_redirect_to product_path(dress.id)
      # TODO: it's actually redirecting to the fallback

      expect(flash[:error]).must_equal "Error: Could not update product order"
    end

    it "reduces the order product count by 1 if quantity is adjusted to 0" do
      # Arrange
      start_count = pending_order.order_products.count

      op_hash = {
        order_product: {
          product_id: dresses.product_id,
          order: dresses.order,
          status: dresses.status,
          quantity: 0
        }
      }

      op = OrderProduct.find_by(id: dresses.id)

      expect {
        patch order_product_path(op.id), params: op_hash
      }.must_change 'OrderProduct.count', -1

      # TODO: not saving to pending_order, likely because creating new order in @current_order
      expect(Order.find_by(id: pending_order.id).order_products.count).must_equal (start_count - 1)

      must_respond_with :redirect
      must_redirect_to cart_path

      expect(op.product_id).must_equal op_hash[:order_product][:product_id]
      expect(op.order).must_equal op_hash[:order_product][:order]
      expect(op.status).must_equal op_hash[:order_product][:status]
      expect(op.quantity).must_equal op_hash[:order_product][:quantity]

      expect(flash[:success]).must_equal "Removed #{op.product.name} from cart"
    end
  end

  describe "destroy" do
    it "succeeds for an existing order product ID" do
      get cart_path

      expect {
        delete order_product_path(dresses.id)
      }.must_change 'OrderProduct.count', -1

      must_respond_with :redirect
      must_redirect_to cart_path

      expect(flash[:success]).must_equal "Removed #{dresses.product.name} from cart"

      expect(OrderProduct.find_by(id: dresses.id)).must_be_nil
    end

    it "displays a flash message and does not update the DB for a bogus order product" do
      id = -1

      expect {
        delete order_product_path(id)
      }.wont_change 'OrderProduct.count'
      # TODO: generates error in controller because tries to call destroy on nil

      must_respond_with :redirect
      must_redirect_to cart_path

      expect(flash[:error]).must_equal "Error: Could not remove #{dresses.product.name} from cart"
    end
  end
end
