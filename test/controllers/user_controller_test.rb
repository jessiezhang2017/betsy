require "test_helper"

describe UserController do

  it "logs in an existing user" do
    start_count = User.count

    perform_login(user)
    must_redirect_to root_path
    session[:user_id].must_equal  user.id

    # Should *not* have created a new user
    User.count.must_equal start_count
  end

  it "should get index" do
    get user_index_url
    value(response).must_be :success?
  end

  it "should get new" do
    get user_new_url
    value(response).must_be :success?
  end

  it "should get show" do
    get user_show_url
    value(response).must_be :success?
  end

  it "should get update" do
    get user_update_url
    value(response).must_be :success?
  end

  it "should get destroy" do
    get user_destroy_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get user_edit_url
    value(response).must_be :success?
  end

  it "should get create" do
    get user_create_url
    value(response).must_be :success?
  end

end
