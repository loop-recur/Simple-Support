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
    
    it "has a first received time" do
      first_time = Time.parse('10/10/10 10:00pm')
      last_time = Time.parse('11/11/11 11:00pm')
      first_message = Factory.build(:message, :created_at => first_time)
      last_message = Factory.build(:message, :created_at => last_time)
      @discussion.messages = [first_message, last_message]
      @discussion.times[:first_received].should == first_time
      @discussion.times[:last_replied].should == last_time
    end
  end
  
end
