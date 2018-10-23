require "test_helper"

describe Product do
  let(:product) { products(:shirt) }
  let(:product2) {products(:dress)}
  let(:user) { users(:user1) }
  let(:category1) {categories(:category1)}
  let(:category2) {categories(:category2)}

  it "must be valid" do
      expect(product).must_be :valid?
    end

  it 'has required fields' do
    fields = [:name, :user_id, :stock, :category_id, :price, :status]

    fields.each do |field|
      expect(product).must_respond_to field
    end
  end

  describe "validations" do
    it "requires a name" do
      product.name = nil
      product.valid?.must_equal false
      product.errors.messages.must_include :name
    end

    it "requires unique names w/in categories" do

      prod1 = Product.new(name: "Polo shirt")
      prod1.user = user
      prod1.stock = 10
      prod1.price = 5
      prod1.category = category1

      prod1.save!

      prod2 = Product.new(name: "Polo shirt")
      prod2.user = user
      prod2.stock = 10
      prod2.price = 5
      prod2.category = category1

      prod2.valid?.must_equal false
      prod2.errors.messages.must_include :name
    end

    it "does not require a unique name if the category is different" do

      prod1 = Product.new(name: "Polo shirt")
      prod1.user = user
      prod1.stock = 10
      prod1.price = 5
      prod1.category = category1

      prod1.save!
      last = Product.all.count

      prod2 = Product.new(name: "Polo shirt")
      prod2.user = user
      prod2.stock = 10
      prod2.price = 5
      prod2.category = category2

      prod2.save!
      expect(Product.all.count).must_equal last+1
    end

    it "requires a user_id" do
      product.user_id = nil
      product.valid?.must_equal false
      product.errors.messages.must_include :user_id
    end

    it "requires a category_id" do
      product.category_id = nil
      product.valid?.must_equal false
      product.errors.messages.must_include :category_id
    end


    it "reject a invalid stock value" do
      product.stock = nil
      product.valid?.must_equal false
      product.errors.messages.must_include :stock
    end


    it " stock value cannot be negative" do
      product.stock = -1
      product.valid?.must_equal false

    end

    it " stock value can be 0" do
      last = Product.all.count

      prod2 = Product.new(name: "Polo shirt")
      prod2.user = user
      prod2.stock = 0
      prod2.price = 5
      prod2.category = category2

      prod2.save!
      expect(Product.all.count).must_equal last+1
    end

    it "it only accept integers as stock quantity" do
      product.stock = 2.1

      product.valid?.must_equal false

    end

    it "reject invalid price" do
      product.price = nil
      product.valid?.must_equal false
      product.errors.messages.must_include :price
    end

    it "accept 0 price" do
      last = Product.all.count

      prod2 = Product.new(name: "Polo shirt")
      prod2.user = user
      prod2.stock = 0
      prod2.price = 0
      prod2.category = category2

      prod2.save!
      expect(Product.all.count).must_equal last+1
    end
  end


  describe "active_products" do
    it "returns an array" do
      products = Product.active_products
      expect(products).must_be_instance_of Array
    end

    it "returns an empty array if no active products" do
      product.status = false
      product2.status = false
      product.save
      product2.save
      expect(Product.active_products.empty?).must_equal true

    end

    it "returns an array of product" do
      expect(Product.active_products.first).must_be_kind_of Product
    end

    it "The array length will be added by 1 for a newly created product" do
      prod2 = Product.new(name: "Polo shirt")
      prod2.user = user
      prod2.stock = 2
      prod2.price = 1
      prod2.category = category2
      count = Product.active_products.length
      prod2.save!

      expect(Product.active_products.length).must_equal count+1

    end

    it "The array will include all the valid product" do
      expect(Product.active_products.first).must_equal product
      expect(Product.active_products.last).must_equal product2

    end
  end


  describe "self.by_category" do

    it "returns an array of correct product " do
      list1 = Product.by_category(category1)
      expect(list1.count).must_equal 2

      list1.each do |prod|
        prod.must_be_kind_of Product
        prod.category.must_equal category1
      end
    end

    it "returns an empty array if no product in that categor" do
      list2 = category.by_category(category2)
      expect(list2.empty?).must_equal true
    end
  end

  describe "self.by_merchant" do
    before do
      user2 = User.create(
        name: jas
        uid: 89076544
        provider: github
      )

    end

    it "returns an array of correct product " do
      list1 = Product.by_merchant(user)
      expect(list1.count).must_equal 2

      list1.each do |prod|
        prod.must_be_kind_of Product
        prod.merchant.must_equal user
      end
    end

    it "returns an empty array if no product in that merchant" do
      list2 = Product.by_merchant(user2)
      expect(list2.empty?).must_equal true
    end
  end



end
