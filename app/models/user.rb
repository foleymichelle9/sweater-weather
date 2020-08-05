class User < ApplicationRecord
  before_create :set_unique_api_key

  validates :email, uniqueness: true, presence: true
  validates :api_key, uniqueness: true
  has_secure_password

  private

    def set_unique_api_key
      
    end

    def generate_key
      require "pry"; binding.pry
    end
end
