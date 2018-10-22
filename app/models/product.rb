class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reviews

  validates :name, presence: true,
                   uniqueness: { scope: :category }

  validates :user_id, presence: true
  validates :stock, presence: true, numericality: { :only_integer => true, :greater_than_or_equal_to => 0}


  validates :category,  presence: true,
                        inclusion: { in: Category.all }

 def self.active_products
   return Product.all.select {|e| e.status == true}
 end


  def self.to_category_hash
    data = {}
    Category.all.each do |cat|
      data[cat] = by_category(cat)
    end
    return data
  end

  def self.by_category(category)
    self.active_products.select {|prod| prod.category == category}
  end

  def self.to_merchant_hash
    data = {}
    Merchant.all.each do |user|
      data[user] = by_merchant(user)
    end
    return data
  end

  def self.by_merchant(merchant)
    self.active_products.select {|prod| prod.user == merchant}
  end


end
