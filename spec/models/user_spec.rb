require "rails_helper"

RSpec.describe User, type: :model do
  describe "creation" do
    before do
      @user = User.create(email: "unittest@test.com", password: "asdfasdf", password_confirmation: "asdfasdf")
    end

    it "can be created" do
      expect(@user).to be_valid
    end

    # it "cannot be created without first_name, last_name" do
    #   # expect(@user).to be_valid
    # end
  end
end
