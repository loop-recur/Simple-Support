require 'spec_helper'

describe User::Factory do
  
  it "creates a valid user with a temp password" do
    u = User::Factory.create(:name => "brian", :email => "brian@looprecur.com")
    u.valid?.should be_true
    u.password.should_not be_blank
  end
  
end
