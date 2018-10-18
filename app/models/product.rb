class Product < ApplicationRecord
  belongs_to :user

  validates :name, presence :true,
                   uniqueness: { scope: :category }

  validates :price, presence :true

  validates :user_id, presence :true
  validates :stock, presence :true

  validates :category,  presence: true,
                        inclusion: { in: @category }

  before_validation :fix_category

  def self.to_category_hash
    data = {}
    CATEGORIES.each do |cat|
      data[cat] = by_category(cat)
    end
    return data
  end

  def self.by_category(category)
    category = category.singularize.downcase
    self.where(category: category).order(vote_count: :desc)
  end

  


  private
    def fix_category
      if self.category
        self.category = self.category.downcase.singularize
      end
    end
  end

end
