require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it { should validate_presence_of :email }
  end
  describe "Instance Methods" do
    it "generate_unique_api_key" do
      user = User.create(email: 'email@example.com')
      expect(user.api_key).to_not eq(nil)

      user_2 = User.create(email: 'email2@example.com')
      expect(user_2.api_key).to_not eq(user.api_key)
    end
  end
end
