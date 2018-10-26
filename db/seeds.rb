# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'date'

category_failures = []

cate_list = ["book", "movie","album","furnitue","appliance"]

cate_list.each do |cate|
  category = Category.new
  category.name = cate
  successful = category.save
  if !successful
    category_failures << category
    puts "Failed to save category: #{category.inspect}"
  else
    puts "Created category: #{category.inspect}"
  end
end

puts "Added #{Category.count} category records"
puts "#{category_failures.length} category failed to save"



user_failures = []

5.times do |i|
  user_name = Faker::Name.name
  user = User.new
  user.name = user_name
  user.uid = rand(10)
  user.provider = "github"
  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}" # so user can check that work to see what happened
  else
    puts "Created user: #{user.inspect}"
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"

merchant_failures = []

8.times do |i|
  merchant_name = Faker::Name.name
  merchant = Merchant.new
  merchant.type = "Merchant"
  merchant.name = merchant_name
  merchant.uid = rand(10)
  merchant.provider = "github"
  successful = merchant.save
  if !successful
    merchant_failures << merchant
    puts "Failed to save merchant: #{merchant.inspect}" # so user can check that work to see what happened
  else
    puts "Created merchant: #{merchant.inspect}"
  end
end

puts "Added #{Merchant.count} merchant records"
puts "#{merchant_failures.length} merchant failed to save"

product_failures = []

10.times do |i|

  merchant_list = Merchant.all
  user = merchant_list.sample
  product_name = Faker::Name.name

  product = Product.new
  product.name = product_name
  product.stock = rand(5)
  product.description = "just a test"
  product.price = 100

  product.user = user
  product.photo_url = "https://pixfeeds.com/images/33/609988/1200-609988-483425824.jpg"
  successful = product.save

  if !successful
    product_failures << product
    puts "Failed to save product: #{product.inspect}" # so user can check that work to see what happened
  else
    puts "Created product: #{product.inspect}"
  end
end

puts "Added #{Product.count} product records"
puts "#{product_failures.length} products failed to save"

Product.all.each do |prod|
  a = Category.all.shuffle
  prod.categories << a.first
  prod.categories << a.last
end
