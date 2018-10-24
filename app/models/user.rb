class User < ApplicationRecord
  has_many :products #TODO REMOVE FOR ANY USER
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
       return self.type == "Merchant"
    end

    #when a the type "Merchant" is added to a User instance, it will actually become an instance of Merchant rather than a User instance with type Merchant
    def become_merchant
      self.becomes!(Merchant) if self.type_must_be_merchant
      self.save!
    end

    #helper method
    def type_must_be_merchant #custom validation to assure that only type merchant can be subclass Merchant
      self.is_a_merchant? ? true : errors.add(:type, "the user's type must be set to Merchant")
    end

end
