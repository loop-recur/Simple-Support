require 'spec_helper'

class User
  
describe TicketHolder::Factory do
  
  it "creates a valid user with a temp password" do
    u = TicketHolder::Factory.create(:name => "brian", :email => "brian@looprecur.com", :account_id => 1)
    u.valid?.should be_true
    u.password.should_not be_blank
  end
  
end

end
