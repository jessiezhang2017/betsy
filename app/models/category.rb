class Category < ApplicationRecord
  has_many :products
  validates :name, presence: true

  def self.category_list
   return Category.all.map do |category|
    [category.name]
   end
 end
 
end
