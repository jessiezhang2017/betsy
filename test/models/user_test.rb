require "test_helper"

describe User do

  describe Merchant do
    let (:merchant) {merchant(:merchant)}
  end

  let(:user) { user(:user1) }

  it "must be valid" do
    value(:user).must_be :valid?
  end
end
