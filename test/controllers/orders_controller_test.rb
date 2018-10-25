require "test_helper"

describe OrdersController do
  let(:pending_order) { orders(:pending_order) }
  let(:empty_order) { orders(:empty_order) }

  describe 'index' do
    # dont know yet
  end

  describe "cart" do
    #TODO dont know how to test these since we dont have a create order path..... @current_order is created or looked up before every controller action
    it "succeeds when things are in the cart" do
      # Arrange

      # Act
      get cart_path

      # Assert
      must_respond_with :success
    end

    it "succeeds when nothing is in the cart" do
      # Arrange

      # Act
      get cart_path

      # Assert
      must_respond_with :success
    end

    # not sure we need a nil case since @current_order is never nil?
  end

  describe "update" do
    it "succeeds for valid data and an existing order ID" do
      # Arrange done with let
      order_hash = {
        order: {
          status: pending_order.status,
          user: pending_order.user,
          order_products: pending_order.order_products
        }
      }

      expect {
        patch order_path(pending_order.id), params: order_hash
      }.wont_change 'Order.count'

      order = Order.find_by(id: pending_order.id)

      must_respond_with :success
      must_redirect_to confirmation_path

      expect(pending_order.status).must_equal "paid"
    end

    # it "renders bad_request for bogus data" do
    #   work_hash = {
    #     work: {
    #       title: nil,
    #       creator: poodr.creator,
    #       description: poodr.description,
    #       publication_year: poodr.publication_year,
    #       category: poodr.category
    #     }
    #   }
    #
    #   work = Work.find_by(id: poodr.id)
    #
    #   expect {
    #     patch work_path(work.id), params: work_hash
    #   }.wont_change 'Work.count'
    #
    #   must_respond_with :bad_request
    #   expect(flash[:result_text]).must_equal "Could not update #{work_hash[:work][:category]}"
    #
    #   # expect no change
    #   expect(work.title).must_equal poodr.title
    #   expect(work.creator).must_equal poodr.creator
    #   expect(work.description).must_equal poodr.description
    #   expect(work.publication_year).must_equal poodr.publication_year
    #   expect(work.category).must_equal poodr.category
    # end
    #
    # it "renders 404 not_found for a bogus work ID" do
    #   work_hash = {
    #     work: {
    #       title: poodr.title,
    #       creator: poodr.creator,
    #       description: "won't work",
    #       publication_year: poodr.publication_year,
    #       category: poodr.category
    #     }
    #   }
    #
    #   id = -1
    #
    #   expect {
    #     patch work_path(id), params: work_hash
    #   }.wont_change 'Work.count'
    #
    #   must_respond_with :not_found
    # end
  end

end
