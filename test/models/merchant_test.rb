require "test_helper"

describe Merchant do
  let(:merchant) { merchants(:merchant1) }

  it "must be valid" do
    value(buyer).must_be :valid?
  end

  it 'must be an instance of user' do
    expect(:merchant).must_be_instance_of User
  end

  it 'must be an instance of merchant' do
    expect(:merchant).must_be_instance_of Merchant
  end
end
