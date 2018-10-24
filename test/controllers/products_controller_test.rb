require "test_helper"

describe ProductsController do
  let(:product) { products(:shirt) }
  let(:product2) {products(:dress)}
  let(:user) { users(:user1) }
    let(:cc_user) { users(:cc_user) }
  let(:category1) {categories(:category1)}
  let(:category2) {categories(:category2)}


  it "should get index" do
    get products_path

    must_respond_with :success
  end

  describe "show" do
    it "should get a product's show page" do
      # Arrange
      id = products(:shirt).id

      # Act
      get product_path(id)

      # Assert
      must_respond_with :success
    end

    it "should respond with not_found if given an invalid id" do
      # Arrange - invalid id
      id = -1

      # Act
      get product_path(id)

      # Assert
      must_respond_with :not_found
      expect(flash[:danger]).must_equal "Cannot find the product -1"
    end
  end

  describe "new" do
    it "can get the new product page" do

      # Act
      get new_product_path

      # Assert
      must_respond_with :success
    end

    it "can get the form with the new_product_path with user logged in" do
      # Arrange

      user = users(:cc_user)
      perform_login(user)
      expect(session[:user_id]).wont_be_nil

      id = products(:product).id

      # Act
      get new_product_path(id)
      # Assert
      must_respond_with :success
    end
    it "will not get new product form if not logged in" do
      # Arrange
      expect(session[:user_id]).must_equal nil
      # Act
      get new_product_path(id)

      # Assert

    end

  end

  # describe "edit" do
  #   it "can get the edit page for a valid book" do
  #     # Arrange
  #     id = books(:poodr).id
  #
  #     # Act
  #     get edit_book_path(id)
  #
  #     # Assert
  #     must_respond_with :success
  #   end
  #
  #   it "should respond with not_found if given an invalid id" do
  #     # Arrange - invalid id
  #     id = -1
  #
  #     # Act
  #     get edit_book_path(id)
  #
  #     # Assert
  #     expect(response).must_be :not_found?
  #     must_respond_with :not_found
  #     expect(flash[:danger]).must_equal "Cannot find the book -1"
  #   end
  #
  #   # not log in user cannot edit
  #
  #   # log in user can edit own
  #
  #   # logn in user cannot edit others
  #
  #   # display not found for invalid post id..
  #
  #
  # end
  #
  # describe "destroy" do
  #   it "can destroy a book given a valid id" do
  #     # Arrange
  #     id = books(:poodr).id
  #     title = books(:poodr).title
  #
  #     # Act - Assert
  #     expect {
  #       delete book_path(id)
  #     }.must_change 'Book.count', -1
  #
  #     must_respond_with :redirect
  #     must_redirect_to books_path
  #     expect(flash[:success]).must_equal "#{title} deleted"
  #     expect(Book.find_by(id: id)).must_equal nil
  #   end
  #
  #   it "should respond with not_found for an invalid id" do
  #     id = -1
  #
  #     # Equivalent
  #     # before_count = Book.count
  #     # delete book_path(id)
  #     # after_count = Book.count
  #     # expect(before_count).must_equal after_count
  #
  #     expect {
  #       delete book_path(id)
  #       # }.must_change 'Book.count', 0
  #     }.wont_change 'Book.count'
  #
  #     must_respond_with :not_found
  #     expect(flash.now[:danger]).must_equal "Cannot find the book #{id}"
  #   end
  #   # only logged in user can delete their own user id /delete/user/:id
  #   # delete /user   can only delete a user who is logged in , so they can delete themselves, no-one else.
  #   # delete a user with all their post
  #   # dependant: nullify
  #   # for invlid id , repond with not_found
  #   # making sure the system is not fail if a use has no post delete its self , and did not cause the issue.
  #   #
  # end
  #
  # describe "create & update" do
  #   let (:book_hash) do
  #     {
  #       book: {
  #         title: 'White Teeth',
  #         author_id: authors(:galbraith).id,
  #         description: 'Good book'
  #       }
  #     }
  #   end
  #
  #
  #   describe "create" do
  #     it "can create a new book given valid params" do
  #       # Act-Assert
  #       expect {
  #         post books_path, params: book_hash
  #       }.must_change 'Book.count', 1
  #
  #       must_respond_with :redirect
  #       must_redirect_to book_path(Book.last.id)
  #
  #       expect(Book.last.title).must_equal book_hash[:book][:title]
  #       expect(Book.last.author).must_equal Author.find_by(id: book_hash[:book][:author_id])
  #       expect(Book.last.description).must_equal book_hash[:book][:description]
  #
  #     end
  #
  #     it "responds with an error for invalid params" do
  #       # Arranges
  #       book_hash[:book][:title] = nil
  #
  #       # Act-Assert
  #       expect {
  #         post books_path, params: book_hash
  #       }.wont_change 'Book.count'
  #
  #       must_respond_with :bad_request
  #
  #     end
  #   end
  #
  #   describe "update" do
  #     it "can update a model with valid params" do
  #       id = books(:poodr).id
  #
  #       expect {
  #         patch book_path(id), params: book_hash
  #       }.wont_change 'Book.count'
  #
  #       must_respond_with :redirect
  #       must_redirect_to book_path(id)
  #
  #       new_book = Book.find_by(id: id)
  #
  #       expect(new_book.title).must_equal book_hash[:book][:title]
  #       expect(new_book.author_id).must_equal book_hash[:book][:author_id]
  #       expect(new_book.description).must_equal book_hash[:book][:description]
  #     end
  #     it "gives an error if the book params are invalid" do
  #       # Arrange
  #       book_hash[:book][:title] = nil
  #       id = books(:poodr).id
  #       old_poodr = books(:poodr)
  #
  #
  #       expect {
  #         patch book_path(id), params: book_hash
  #       }.wont_change 'Book.count'
  #       new_poodr = Book.find(id)
  #
  #       must_respond_with :bad_request
  #       expect(old_poodr.title).must_equal new_poodr.title
  #       expect(old_poodr.author_id).must_equal new_poodr.author_id
  #       expect(old_poodr.description).must_equal new_poodr.description
  #     end
  #     it "gives not_found for a book that doesn't exist" do
  #       id = -1
  #
  #       expect {
  #         patch book_path(id), params: book_hash
  #       }.wont_change 'Book.count'
  #
  #       must_respond_with :not_found
  #
  #     end
  #   end
  #
  #
  #
  # end

end
