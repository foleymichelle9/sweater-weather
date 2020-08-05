class User < ApplicationRecord

  before_create :give_unique_api_key

  validates :email, uniqueness: true, presence: true
  validates :api_key, uniqueness: true
  has_secure_password

  private

  def give_unique_api_key
    self.api_key = generate_key
  end

  def generate_key
    loop do
      key = SecureRandom.hex(10)
      break key unless User.where(api_key: key).exists?
    end
  end
end
