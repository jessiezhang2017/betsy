class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reviews

  validates :name, presence: true,
                   uniqueness: { scope: :category }

  validates :price, presence: true

  validates :user_id, presence: true
  validates :stock, presence: true

  validates :category,  presence: true,
                        inclusion: { in: Category.all }



  #
  #
  # def self.to_category_hash
  #   data = {}
  #   Category.all.each do |cat|
  #     data[cat] = by_category(cat)
  #   end
  #   return data
  # end
  #
  # def self.by_category(category)
  #   self.where(category: category)
  # end
  #
  # def self.to_merchant_hash
  #   data = {}
  #   Merchant.all.each do |user|
  #     data[user] = by_merchant(user)
  #   end
  #   return data
  # end
  #
  # def self.by_merchant(merchant)
  #   self.where(user: merchant)
  # end

  def update_stock(quantity_ordered)
    if self.available?(quantity_ordered)
      self.stock -= quantity_ordered
      return self.save
    else
      return false
    end
  end

  def available?(quantity_ordered)
    return false unless (quantity_ordered >= 1 && (quantity_ordered.is_a? Integer))

    if quantity_ordered <= self.stock
      return true
    else
      return false
    end
  end
end
