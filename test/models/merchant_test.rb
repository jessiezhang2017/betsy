require 'test_helper'

describe Merchant do
  let (:merchant) {merchants(:merchant)}

  it "must be valid" do
    value(merchant).must_be :valid?
  end

  it "must be an instance of Merchant" do
    expect(merchant).must_be_instance_of Merchant
  end

  it "must be kind of User" do
    expect(merchant).must_be_kind_of User
  end

end
