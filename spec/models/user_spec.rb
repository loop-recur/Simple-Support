require 'spec_helper'

describe User do
  before do
    @user = Factory.build(:user)
  end
  
  describe "associations" do
    it { should have_attached_file(:avatar) }
    it { should have_many(:discussions) }
    it { should have_many(:messages) }
    it { should belong_to(:account) }
  end

  describe "validations" do
    it { should validate_presence_of :account_id }
    it { should_not allow_value("superdooper").for :role }
    it { should_not allow_mass_assignment_of(:role) }

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
  
  describe "an instance" do
    
    it "is born with a role of registered" do
      user = User.new(:role => nil)
      user.role.should == "ticket_holder"
    end
    
    it "has a query method for each role" do
      @user.role = "agent"
      @user.ticket_holder?.should be_false
      @user.agent?.should be_true
    end

    it "returns true for admin or agent" do
      @user.role = "admin"
      @user.admin_access?.should be_true
      @user.role = "agent"
      @user.admin_access?.should be_true
    end

    it "returns false for non-admins" do
      @user.role = "ticket_holder"
      @user.admin_access?.should be_false
    end

    it "has a default avatar" do
      @user.avatar = nil
      @user.avatar.url.should match(/users\/default.png/)
      @user.avatar.url(:large).should match(/users\/large.png/)
    end
  end
    
end
