class Merchant < User
  has_many :products
  validates :type, presence: true
  #merchant inherits all things from user, but when a new merchant is created the 'type' is automagically set to merchant.

  #create method to be sure it is not nil, then add to validation
  #merchant needs ability to fulfill orders as 'shipped'

end
