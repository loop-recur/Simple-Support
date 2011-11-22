require 'spec_helper'

describe Discussion do
  before do
    @discussion = Factory.build(:discussion)
  end
  
  context "associations" do
    it { should belong_to(:user) }
    it { should have_many(:messages) }
  end
  
  context "validations" do
    it { should validate_presence_of :account_id }
    it { should validate_presence_of :user_id }
  end
  
  context "an instance" do
    
    it "has an initial message" do
      messages = [Factory.build(:message), Factory.build(:message)]
      @discussion.messages = messages
      @discussion.initial_message.should == messages.first
    end
    
    it "has a title" do
      @discussion.initial_message.body = "A really long body about how mad this user is in regard to bugs"
      @discussion.title.should == "A really long body about ho..."
    end
  end
  
end
