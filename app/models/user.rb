class User < ApplicationRecord
  has_many :orders


    def self.build_from_github(auth_hash)
     user = User.new
     user.uid = auth_hash[:uid]
     user.provider = 'github'
     user.name = auth_hash['info']['name']
     user.email = auth_hash['info']['email']

     # Note that the user has not been saved
     return user
    end

    def is_a_merchant?
        return true if user ||= User.find_by(type: "Merchant")

    end
end
