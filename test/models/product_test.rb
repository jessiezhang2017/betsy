require "test_helper"

describe Product do
  let(:product) { products(:shirt) }
  let(:user) { users(:user1) }
<<<<<<< HEAD
  before do
    @cloth = Category.new(name: "cloth")
    @cloth.save

    @cloth = Category.new(name: "outdoor")
    @cloth.save

  end
=======
  let(:category1) {categories(:category1)}
  let(:category2) {categories(:category2)}

>>>>>>> pd_new_2

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
<<<<<<< HEAD
      prod1.category = @cloth
=======
      prod1.category = category1
>>>>>>> pd_new_2

      prod1.save!

      prod2 = Product.new(name: "Polo shirt")
      prod2.user = user
      prod2.stock = 10
      prod2.price = 5
<<<<<<< HEAD
=======
      prod2.category = category1

      prod2.valid?.must_equal false
>>>>>>> pd_new_2
      prod2.errors.messages.must_include :name
    end

    it "does not require a unique name if the category is different" do

      prod1 = Product.new(name: "Polo shirt")
      prod1.user = user
      prod1.stock = 10
      prod1.price = 5
<<<<<<< HEAD
      prod1.category = @cloth

      prod1.save!
      last = product.all.count
=======
      prod1.category = category1

      prod1.save!
      last = Product.all.count
>>>>>>> pd_new_2

      prod2 = Product.new(name: "Polo shirt")
      prod2.user = user
      prod2.stock = 10
      prod2.price = 5
<<<<<<< HEAD
      prod1.category = @dress

      product.save!
      expect(Product.all.count).must_equal last+1
    end

  #   it "allows the three valid categories" do
  #     valid_categories = ['album', 'book', 'movie']
  #     valid_categories.each do |category|
  #       work = Work.new(title: "test", category: category)
  #       work.valid?.must_equal true
  #     end
  #   end
  #
  #   it "fixes almost-valid categories" do
  #     categories = ['Album', 'albums', 'ALBUMS', 'books', 'mOvIeS']
  #     categories.each do |category|
  #       work = Work.new(title: "test", category: category)
  #       work.valid?.must_equal true
  #       work.category.must_equal category.singularize.downcase
  #     end
  #   end
  #
  #   it "rejects invalid categories" do
  #     invalid_categories = ['cat', 'dog', 'phd thesis', 1337, nil]
  #     invalid_categories.each do |category|
  #       work = Work.new(title: "test", category: category)
  #       work.valid?.must_equal false
  #       work.errors.messages.must_include :category
  #     end
  #   end
  #
  #   it "requires a name" do
  #     work = Work.new(category: 'ablum')
  #     work.valid?.must_equal false
  #     work.errors.messages.must_include :title
  #   end
  #
  #   it "requires unique names w/in categories" do
  #     category = 'album'
  #     title = 'test title'
  #     work1 = Work.new(title: title, category: category)
  #     work1.save!
  #
  #     work2 = Work.new(title: title, category: category)
  #     work2.valid?.must_equal false
  #     work2.errors.messages.must_include :title
  #   end
  #
  #   it "does not require a unique name if the category is different" do
  #     title = 'test title'
  #     work1 = Work.new(title: title, category: 'album')
  #     work1.save!
  #
  #     work2 = Work.new(title: title, category: 'book')
  #     work2.valid?.must_equal true
  #   end
  # end
  #
  # describe "vote_count" do
  #   it "defaults to 0" do
  #     work = Work.create!(title: "test title", category: "movie")
  #     work.must_respond_to :vote_count
  #     work.vote_count.must_equal 0
  #   end
  #
=======
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

    end

    it "returns an array of product" do


    end

    it "The array length will be added by 1 for a newly created product" do


    end

    it "The array length will be reduced by 1 if retire a valid product" do


    end
  end

>>>>>>> pd_new_2
  #   it "tracks the number of votes" do
  #     work = Work.create!(title: "test title", category: "movie")
  #     4.times do |i|
  #       user = User.create!(username: "user#{i}")
  #       Vote.create!(user: user, work: work)
  #     end
  #     work.vote_count.must_equal 4
  #     Work.find(work.id).vote_count.must_equal 4
  #   end
  # end
  #
  # describe "top_ten" do
  #   before do
  #     # TODO DPR: This runs pretty slow. Fixtures?
  #     # Create users to do the voting
  #     test_users = []
  #     20.times do |i|
  #       test_users << User.create!(username: "user#{i}")
  #     end
  #
  #     # Create media to vote upon
  #     Work.where(category: "movie").destroy_all
  #     8.times do |i|
  #       work = Work.create!(category: "movie", title: "test movie #{i}")
  #       vote_count = rand(test_users.length)
  #       test_users.first(vote_count).each do |user|
  #         Vote.create!(work: work, user: user)
  #       end
  #     end
  #   end
  #
  #   it "returns a list of media of the correct category" do
  #     movies = Work.top_ten("movie")
  #     movies.length.must_equal 8
  #     movies.each do |movie|
  #       movie.must_be_kind_of Work
  #       movie.category.must_equal "movie"
  #     end
  #   end
  #
  #   it "orders media by vote count" do
  #     movies = Work.top_ten("movie")
  #     previous_vote_count = 100
  #     movies.each do |movie|
  #       movie.vote_count.must_be :<=, previous_vote_count
  #       previous_vote_count = movie.vote_count
  #     end
  #   end
  #
  #   it "returns at most 10 items" do
  #     movies = Work.top_ten("movie")
  #     movies.length.must_equal 8
  #
  #     Work.create(title: "phase 2 test movie 1", category: "movie")
  #     Work.top_ten("movie").length.must_equal 9
  #
  #     Work.create(title: "phase 2 test movie 2", category: "movie")
  #     Work.top_ten("movie").length.must_equal 10
  #
  #     Work.create(title: "phase 2 test movie 3", category: "movie")
  #     Work.top_ten("movie").length.must_equal 10
  #   end
  end
end
