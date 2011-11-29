require 'spec_helper'

describe User do
  before do
    @user = Factory.build(:user)
  end
  
  describe "associations" do
    it { should have_many(:discussions) }
    it { should have_many(:messages) }
    it { should belong_to(:account) }
  end

  describe "validations" do
    it { should validate_presence_of :account_id }

    context "email validation" do
      it { should validate_presence_of :email }
      
      it "is invalid without a uniq email" do
        @user.update_attribute(:email, "brian@thisbythem.com")
        user2 = Factory.build(:user, :email => "brian@thisbythem.com")
        user2.valid?.should be_false
        user2.errors[:email].should include("has already been taken")
      end
      
      it "accepts valid email addresses" do
        addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        addresses.each do |address|
          @user.email = address
          valid_email_user = @user
          valid_email_user.should be_valid
        end
      end
      
      it "rejects invalid email addresses" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
        addresses.each do |address|
          @user.email = address
          invalid_email_user = @user
          invalid_email_user.should_not be_valid
        end
        @user.errors[:email].should include("is invalid") 
      end
    end
    
    context "password validations" do
      it { should validate_presence_of :password }
      
      it "requires a matching password" do
        @user.password, @user.password_confirmation = "foo", "bar"
        @user.valid?.should be_false
        @user.errors[:password].should include("doesn't match confirmation") 
      end      
      
      it "requires a password to be 6 characters long" do
        @user.password, @user.password_confirmation = "short", "short"
        @user.valid?.should be_false
        @user.errors[:password].should include("is too short (minimum is 6 characters)")
      end
      
    end
  end
      
end
