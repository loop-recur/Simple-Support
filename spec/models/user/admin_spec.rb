require 'spec_helper'

class User
  
describe Admin do
  before do
    @user = Admin.new
  end
  
  describe "associations" do
    it { should have_attached_file(:avatar) }
  end
  
  describe "an instance" do
    
    it "has a default avatar" do
      @user.avatar = nil
      @user.avatar.url.should match(/admins\/default.png/)
      @user.avatar.url(:large).should match(/admins\/large.png/)
    end
  end
    
end

end