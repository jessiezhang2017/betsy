require "test_helper"

describe User do
  let(:user) { :user1 }

  it "must be valid" do
    value(user).must_be :valid?
  end

  it "logs in an existing user" do
    start_count = User.count

    perform_login(user)
    must_redirect_to root_path
    session[:user_id].must_equal  user.id

    # Should *not* have created a new user
    User.count.must_equal start_count
  end
end
