class User < ApplicationRecord
  has_many :products
  has_many :orders
<<<<<<< HEAD
=======

>>>>>>> 0c6ef2e5c395e6344a8b8a1ab4bddd195afbeeff

    def self.build_from_github(auth_hash)
     user = User.new
     user.uid = auth_hash[:uid]
     user.provider = 'github'
     user.name = auth_hash['info']['name']
     user.email = auth_hash['info']['email']

     # Note that the user has not been saved
     return user
    end

    def is_a_merchant?(user)
       return (user.type == "Merchant")
    end
end
