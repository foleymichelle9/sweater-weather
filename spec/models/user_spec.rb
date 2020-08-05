require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it { should validate_presence_of :email }
  end
  describe "Instance Methods" do
    it "give_unique_api_key" do
      user = User.create_user(email: 'email1@example.com',
                              password: 'password',
                              password_confirmation: 'password'
                             )
      expect(user.api_key).to_not eq(nil)

      user_2 = User.create(email: 'email2@example.com')
      expect(user_2.api_key).to_not eq(user.api_key)
    end
  end
end
