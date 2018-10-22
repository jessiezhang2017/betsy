require "test_helper"

describe OrderProduct do
  let(:shirts) { order_products(:shirts) }
  let(:dresses) { order_products(:dresses) }

  it "must be valid" do
    value(shirts).must_be :valid?
  end

  it 'has required fields' do
    fields = [:quantity, :product_id, :order_id]

    fields.each do |field|
      expect(shirts).must_respond_to field
    end
  end

  describe "relationships" do
    it "must belong to an order" do
      # Arrange is done with let

      # Act
      order = shirts.order

      # Assert
      expect(shirts).must_be_instance_of OrderProduct
      expect(order).must_be_instance_of Order
    end

    it "must belong to a product" do
      # Arrange is done with let

      # Act
      product = shirts.product

      # Assert
      expect(shirts).must_be_instance_of OrderProduct
      expect(product).must_be_instance_of Product
    end
  end

  describe "validations" do
    it "must have a quantity" do
      # Arrange
      shirts.quantity = nil

      # Act
      valid = shirts.valid?

      # Assert
      expect(valid).must_equal false
      expect(shirts.errors.messages).must_include :quantity
      expect(shirts.errors.messages[:quantity]).must_include "can't be blank", "is not a number"

      # Rearrange
      shirts.quantity = 2

      # Re-Act
      valid = shirts.valid?

      # Reassert
      expect(valid).must_equal true
    end

    it "must have an integer quantity greater than or equal to 1" do
      # Arrange done with let

      # Act
      qt = shirts.quantity

      # Assert
      expect(qt).must_be_instance_of Integer
      expect(qt).must_be :>=, 1
    end

    it "must have an order" do
      # Arrange
      shirts.order = nil

      # Act
      valid = shirts.valid?

      # Assert
      expect(valid).must_equal false
      expect(shirts.errors.messages).must_include :order
      expect(shirts.errors.messages[:order]).must_include "can't be blank", "must exist"

      # Rearrange
      shirts.order = orders(:pending_order)

      # Re-Act
      valid = shirts.valid?

      # Reassert
      expect(valid).must_equal true
    end

    it "must have a product" do
      # Arrange
      shirts.product = nil

      # Act
      valid = shirts.valid?

      # Assert
      expect(valid).must_equal false
      expect(shirts.errors.messages).must_include :product
      expect(shirts.errors.messages[:product]).must_include "can't be blank", "must exist"

      # Rearrange
      shirts.product = products(:shirt)

      # Re-Act
      valid = shirts.valid?

      # Reassert
      expect(valid).must_equal true
    end
  end

  describe "subtotal" do
    it "must return a float" do
      # Arrange done with let

      # Act
      result = dresses.subtotal

      # Assert
      expect(result).must_be_instance_of Float
    end

    it "must return the cost of the product times its quantity" do
      # Arrange done with let

      # Act
      result = dresses.subtotal

      # Assert
      expect(result).must_equal dresses.quantity * products(:dress).price
    end
  end

  describe "edit_quantity" do
    it "updates the quantity to the designated value" do
      # Arrange done with let

      # Act - Assert
      expect{
        dresses.edit_quantity(3)
      }.must_change 'dresses.quantity', 1 #previously 2
    end

    it "cannot update the quantity to a value less than 1 or a non-integer" do
      # Arrange done with let

      # Act - Assert
      expect{
        dresses.edit_quantity(0)
      }.wont_change 'dresses.quantity'

      expect{
        dresses.edit_quantity(-1)
      }.wont_change 'dresses.quantity'

      expect{
        dresses.edit_quantity(2.5)
      }.wont_change 'dresses.quantity'
    end

    it "must return true when successful" do
      # Arrange done with let

      # Act - Assert
      expect(dresses.edit_quantity(3)).must_equal true
    end

    it "must return false when unsuccessful" do
      # Arrange done with let

      # Act - Assert
      expect(dresses.edit_quantity(-2)).must_equal false
    end

    it "cannot increase the quantity beyond the available stock" do
      # Arrange done with let

      # Act - Assert
      expect{
        dresses.edit_quantity(products(:dress).stock + 1)
      }.wont_change 'dresses.quantity'

      expect(dresses.edit_quantity(products(:dress).stock + 1)).must_equal false
    end
  end

  describe "update_stock" do
    it "reduces the stock by the quantity ordered" do
      expect{
        dresses.update_stock(2)
      }.must_change 'dresses.quantity', 2
    end

    it "returns true if successful" do
      expect(dresses.update_stock(2)).must_equal true
    end

    it "returns false if unsuccessful" do
      expect(dresses.update_stock(2)).must_equal false
    end

    it "cannot reduce the stock below 0 or to a non-integer" do
      # Arrange done with let

      # Act - Assert
      expect{
        dresses.update_stock(dresses.product.stock + 1)
      }.wont_change 'dresses.quantity'

      expect{
        dresses.update_stock(1.5)
      }.wont_change 'dresses.quantity'
    end
  end
end
