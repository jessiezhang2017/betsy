require "test_helper"

describe OrderProduct do
  let(:shirts) { order_products(:shirts) }
  let(:dresses) { order_products(:dresses) }

  it "must be valid" do
    value(shirts).must_be :valid?
  end

  describe "relationships" do
    it "must belong to an order" do
    end

    it "must belong to a product" do
    end
  end

  describe "validations" do
    it "must have a quantity" do
    end

    it "must have an integer quantity greater than 0" do
    end

    it "must have an order" do
    end

    it "must have a product" do
    end
  end

  describe "subtotal" do
    it "must return a float" do
    end

    it "must return the cost of the product times its quantity" do
    end
  end
end
