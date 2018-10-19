require "test_helper"

describe Order do
  let(:shopping_order) { orders(:shopping_order) }

  it "must be valid" do
    value(shopping_order).must_be :valid?
  end

  describe "relationships" do
    it "belongs to a user" do
    end

    it "has many order products" do
    end
  end

  describe "validations" do
    it "must have a user" do
    end

    it "must have at least one order product" do
    end

    it "must have only unique order products" do
    end

    it "must have a status" do
    end

    it "must have a status equal to shopping, paid, or shipped" do
    end
  end

  describe "total" do
    it "returns the sum of all of the order's order product subtotals" do
    end

    it "returns a float" do
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
