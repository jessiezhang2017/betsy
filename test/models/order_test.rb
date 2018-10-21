require "test_helper"

describe Order do
  let(:pending_order) { orders(:pending_order) }

  it "must be valid" do
    skip #TODO
    value(pending_order).must_be :valid?
  end

  it 'has required fields' do
    fields = [:status, :user_id]

    fields.each do |field|
      expect(pending_order).must_respond_to field
    end
  end

  describe "relationships" do
    it "belongs to a user" do
      # Arrange is done with let

      # Act
      user = pending_order.user

      # Assert
      expect(pending_order).must_be_instance_of Order
      expect(user).must_be_instance_of User
    end

    it "has many order products" do
      # Arrange is done with let

      # Act
      ops = pending_order.order_products

      # Assert
      expect(pending_order).must_be_instance_of Order

      expect(ops.length).must_be :>=, 1
      ops.each do |op|
        expect(op).must_be_instance_of OrderProduct
      end
    end

    it "has many products through orderproducts(?)" do
      skip #TODO
    end
  end

  describe "validations" do
    it "must have a user" do
      skip #TODO
      # Arrange
      pending_order.user = nil

      # Act
      valid = pending_order.valid?

      # Assert
      expect(valid).must_equal false
      expect(pending_order.errors.messages).must_include :user
      expect(pending_order.errors.messages[:user]).must_include "can't be blank", "must exist"

      # Rearrange
      pending_order.user = users(:user1)

      # Re-Act
      valid = pending_order.valid?

      # Reassert
      expect(valid).must_equal true
    end

    it "must have at least one order product" do
      skip #TODO
      # Arrange done with let

      # Act
      ops = pending_order.order_products

      # Assert
      expect(ops).must_be_instance_of Array
      expect(ops.length).must_be :>=, 1
    end

    it "must have a status" do
      skip #TODO
      # Arrange
      pending_order.status = nil

      # Act
      valid = pending_order.valid?

      # Assert
      expect(valid).must_equal false
      expect(pending_order.errors.messages).must_include :status
      expect(pending_order.errors.messages[:status]).must_include "can't be blank", "must exist"

      # Rearrange
      pending_order.status = "shopping"

      # Re-Act
      valid = pending_order.valid?

      # Reassert
      expect(valid).must_equal true
    end

    it "must have a status equal to shopping, paid, or shipped" do
      skip #TODO
    end
  end

  describe "total" do
    it "returns the sum of all of the order's order product subtotals" do
      # Arrange done with let

      # Act
      result = pending_order.total
      subtotals = pending_order.order_products.map { |op| op.subtotal }

      # Assert
      expect(result).must_equal subtotals.sum
    end

    it "returns a float" do
      # Arrange done with let

      # Act
      result = pending_order.total

      # Assert
      expect(result).must_be_instance_of Float
    end
  end

  describe "add_product" do
    it "adds an order product to the cart" do
    end

    it "updates the existing order product quantity if product already exists in cart" do
    end

    it "creates a new order product in the cart if product not already on order" do
    end
  end
end
